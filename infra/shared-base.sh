#!/usr/bin/env bash
# Says where a copy of the game (staging or production) runs on the shared portfolio base, as
# key=value lines for $GITHUB_OUTPUT, read from the "portfolio-shared" deployment's outputs:
#
#   group=rg-portfolio-shared   the shared base's resource group
#   environment=cae-...         its Container Apps environment
#   server=sql-...              its SQL server
#   location=centralus          its region
#   database=cardarena          this copy's database on that server
#   ready=true                  the database is there, so the game runs on the shared base
#   free=true                   the database is on the free offer, so the deploy keeps it there; false
#                               when someone moved it to a paid tier, which the deploy then leaves alone
#
#   shared-base.sh <shared resource group> <staging|production>
#
# "ready" stays false until the "Move to the shared base" workflow has copied the game's data across,
# so a deploy never points the game at an empty database. See docs/adr/0040-shared-portfolio-base.md.
set -euo pipefail

if [ $# -ne 2 ] || { [ "$2" != staging ] && [ "$2" != production ]; }; then
  echo "Usage: shared-base.sh <shared resource group> <staging|production>" >&2
  exit 2
fi
group=$1
database=cardarena
if [ "$2" = staging ]; then database=cardarena-staging; fi

if ! outputs=$(az deployment group show --resource-group "$group" --name portfolio-shared \
    --query properties.outputs --output json); then
  echo "::error::The shared base isn't deployed to $group. Run infra/setup-shared.ps1 first." >&2
  exit 1
fi
server=$(jq -r .sqlServerName.value <<< "$outputs")
found=$(az sql db list --resource-group "$group" --server "$server" \
  --query "length([?name=='$database'])" --output tsv)

echo "group=$group"
jq -r '"environment=\(.environmentName.value)", "server=\(.sqlServerName.value)", "location=\(.location.value)"' <<< "$outputs"
echo "database=$database"
if [ "$found" = 1 ]; then
  echo "ready=true"
  free=$(az sql db show --resource-group "$group" --server "$server" --name "$database" \
    --query useFreeLimit --output tsv)
  if [ "$free" = true ]; then echo "free=true"; else echo "free=false"; fi
else
  echo "ready=false"
fi
