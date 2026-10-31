# History

Decisions and removals, newest first. The main docs state the current setup
only; this folder keeps what happened and why.

## 2026-10-31 — Shared store deduplicated to one copy per skill

`~/.agents/skills/` held 72 entries. 58 of them duplicated skills shipped by
installed plugins: the whole pstack set (56), `babysit` (claude-mem) and
`karpathy-guidelines` (andrej-karpathy-skills). They were deleted, leaving the
15 plugin-less skills.

Why: both Claude Code and Codex load every plugin skill description into
session context, so an extra unnamespaced copy doubled the cost and drifted
(26 copies had already diverged from their plugin versions). Plugins became
the single source for the removed names.

Consequence: harnesses without a plugin system, such as QwenWork, read
`~/.agents/skills/` directly and lost access to the removed names. The five
operating rules in [Skill layout](../architecture/skill-layout.md#operating-rules)
came out of this change.

## 2026-10-31 — Codex `skill-creator` copy removed

`~/.codex/skills/skill-creator/` duplicated the shared store's copy. Why:
Codex reads `~/.agents/skills/` directly, so the second copy could drift while
shadowing the store's.

## 2026-10-29 — `task-observer` junction removed

The junction in `~/.claude/skills/` pointed at a store folder that no longer
existed. Why: broken link, and the skill itself was already gone, so there was
nothing to restore.

## Earlier — ECC removed from the setup

ECC overlapped the installed plugins. Why: overlapping skills exhausted the
context budget, and ECC's hooks added work to routine sessions. The lesson
kept in the main docs: prefer selected tools over stacking bundles with
duplicate responsibilities.
