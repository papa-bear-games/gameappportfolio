# Status

- 2026-10-13: Repo moved from `scox115` to the `papa-bear-games` GitHub org. The game itself is
  live and unchanged at https://play.scottcoxdev.com. After the move, deploys failed at "Sign in
  to Azure" because Azure only trusted the old repo name. Fixed the same day: Scottie removed the
  old `scox115` federated credentials and re-ran `infra/setup.ps1` for production and staging, so
  Azure now trusts `papa-bear-games/gameappportfolio` (both the name and ID forms). Public
  packages were turned on for the org and the `card-arena-api` package was made public, so
  Azure can pull the image without a token. The setup scripts now repoint an existing credential
  at a new repo name instead of failing with "already exists".
- 2026-10-10: Feature work done to date: boss fights, live duels, ranked seasons, friends,
  spectating, replays, guest play, two-factor sign-in (required for admins), recovery email,
  moderation, staging and previews, shared portfolio base (ADR 0040). See the ADR index.
- Next: whatever Scottie asks for. Dependabot PRs keep arriving and can be merged once green.
