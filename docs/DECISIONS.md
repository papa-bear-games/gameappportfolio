# Decisions

Newest first. Design decisions about the code are ADRs in `docs/adr/`; this file holds decisions
about the repo and the project.

- 2026-10-13: The deploy no longer forces the free offer on a shared database someone moved to a
  paid tier; it leaves it as it is (Claude, so production deploys work again).

- 2026-10-13: Moved the repo from `scox115` to the `papa-bear-games` GitHub org (Scottie). Links,
  setup-script defaults and the image name now use `papa-bear-games`.
- 2026-10-13: Every repo carries `CLAUDE.md`, `docs/STATUS.md` and `docs/DECISIONS.md` so any
  Claude session can pick it up cold (Scottie).
- 2026-10-13: Claude may merge green PRs itself (Scottie).
