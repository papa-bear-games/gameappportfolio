# Status

- 2026-10-13: Repo moved from `scox115` to the `papa-bear-games` GitHub org. The game itself is
  live and unchanged at https://play.scottcoxdev.com (last deploy 2026-10-10, green).
  **Deploys from GitHub are blocked until Scottie re-adds the Azure sign-in trust for the new
  repo name**: Azure only trusts `scox115/gameappportfolio`, so `Deploy to Azure`, the PR
  previews and the monthly restore drill (next on 1 November) fail at "Sign in to Azure". Fix: run
  `infra/setup.ps1` (production) and `infra/setup.ps1 -Environment staging` from a fresh pull,
  then run `Deploy to Azure` by hand. If the API image then fails to pull, make the new
  `card-arena-api` package under the papa-bear-games org public, or check `GHCR_READ_TOKEN`.
- 2026-10-10: Feature work done to date: boss fights, live duels, ranked seasons, friends,
  spectating, replays, guest play, two-factor sign-in (required for admins), recovery email,
  moderation, staging and previews, shared portfolio base (ADR 0040). See the ADR index.
- Next: whatever Scottie asks for. Dependabot PRs keep arriving and can be merged once green.
