<div align="center">

# Skills inventory

*Every installed user-scope skill for Claude Code and Codex, by source*

[Repository](../../README.md) · [Agent setup](../setup/agent-setup.md) · [Plugin skills](plugin-skills.md)

</div>

Agent skills installed at **user scope**, split by source, for Claude Code and Codex.
Snapshot date: 2026-10-31.

## Claude Code (`~/.claude`)

### From plugins (7 plugins, 167 skills)

All installed with `scope: user` (see `~/.claude/plugins/installed_plugins.json`).
Plugin skills appear namespaced as `plugin:skill-name` in the session skill list.
Installed copies live in `cache/<marketplace>/<plugin>/<version>/`; marketplace
clones in `marketplaces/`.

| Plugin | Version | Skills provided |
|---|---|---|
| `superpowers@claude-plugins-official` | 6.1.1 | brainstorming, systematic-debugging, test-driven-development, writing-plans, executing-plans, subagent-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, requesting-code-review, receiving-code-review, finishing-a-development-branch, writing-skills, dispatching-parallel-agents |
| `claude-mem@thedotmack` | 15.5.0 (auto-update) | mem-search, make-plan, do, build, release, babysit, handoff, learn-codebase, smart-explore, pathfinder, standup, how-it-works, knowledge-agent, timeline-report, weekly-digests, mode-creator, cloud-sync, screenpipe, ccs-align, oh-my-issues, version-bump, build-and-release, childhood, design-is, agent-cost-report, what-the, wowerpoint, backup-setup, owner-goals, request-progress (30) |
| `pstack@cursor-plugins` | 0.15.29 | 56 skills: poteto stack (poteto-mode, poteto-help, automate-me), 24 `principle-*` practice skills, plus architect, arena, benchmark-checklist, blast-radius, bro, correct, create-formal-verification-skill, create-verification-skill, figure-it-out, how, in-your-own-words, interrogate, ketchup, maintain-formal-verification-skill, maintain-verification-skill, make-bot-ui, no-comments, recall, reflect, sharpen, setup-pstack, show-me-your-work, swarm, tdd, teach, technical-writing, typescript-best-practices, unslop, why (agents: poteto-agent, comment-sicko) |
| `caveman@caveman` | 4.0.1 | caveman, caveman-commit, caveman-compress, caveman-discover, caveman-evidence-review, caveman-explore, caveman-help, caveman-learn, caveman-manage, caveman-optimize, caveman-review, caveman-setup, caveman-stats, cavecrew, megacave, ultracave, investigate-first, lean-build, migration, safe-refactor, surgical-patch, verify-and-stop. `caveman-init` ships as a command, not a skill (agents: cavecrew-builder, cavecrew-investigator, cavecrew-reviewer) |
| `mattpocock-skills@mattpocock` | 1.3.1 | 38 skills: ask-matt, chief-of-staff, claude-handoff, code-review, codebase-design, diagnosing-bugs, domain-modeling, git-guardrails-claude-code, grill-me, grill-with-docs, grilling, handoff, implement, implement-spec, improve-codebase-architecture, loop-me, migrate-to-shoehorn, pr, prototype, research, retro, scaffold-exercises, setup-matt-pocock-skills, setup-pre-commit, setup-ts-deep-modules, tdd, teach, to-questionnaire, to-spec, to-tickets, triage, wait-what, wayfinder, wizard, writing-beats, writing-fragments, writing-for-agents, writing-shape |
| `ponytail@ponytail` | 5.3.2 | ponytail, ponytail-audit, ponytail-debt, ponytail-gain, ponytail-help, ponytail-review |
| `andrej-karpathy-skills@karpathy-skills` | 1.0.0 | karpathy-guidelines |

### Standalone user-scope skills (`~/.claude/skills/`, 10 links)

All ten entries are NTFS junctions into the shared store
(`~/.agents/skills/<name>`): create-readme, find-skills, git-workflow-and-versioning,
github-ops, hyperframes, hyperframes-cli, hyperframes-registry, impeccable,
media-use, skill-creator. No plain directories remain.

### Built-in Claude Code skills (bundled, not plugins)

claude-api, code-review, dataviz, fewer-permission-prompts, init,
keybindings-help, loop, plugin-authoring, run, security-review, simplify,
update-config, workflow-authoring

## Shared skill store (`~/.agents/skills/`, 15)

Plain directories read directly by QwenWork and other harnesses; every entry is
also linked into `~/.claude/skills/`. Families: the hyperframes trio, plus
create-readme, dev-loop, find-skills, git-workflow-and-versioning, github-ops,
grill-with-docs, impeccable, media-use, setup-matt-pocock-skills, skill-creator,
to-spec and to-tickets. Installed plugins are the single source for the skills
they ship. Removals and reasons: [History](../history/README.md).

## Codex (`~/.codex`)

### Standalone user-scope skills (`~/.codex/skills/`)

- `skills/.system/`. Five built-in system skills: imagegen, openai-docs,
  review-agent, skill-creator (system), skill-installer

Skills load by convention from `$CODEX_HOME/skills`; `config.toml` has no
`[skills]` section, and `.system/` is reserved for Codex's own skills.

`jd-to-portfolio-tutor` lives in Playground project scope (see below).

### From plugins (7, registered in `config.toml`)

Same marketplaces as the Claude side, all enabled: ponytail, caveman,
mattpocock-skills, andrej-karpathy-skills, pstack, superpowers, and claude-mem
via the local variant `claude-mem@claude-mem-local` (`claude-mem@thedotmack` is
disabled on the Codex side). Skills ship without a namespace prefix on Codex.

Versions below are from the 2026-10-24 snapshot (verified set re-checked
2026-10-29; individual versions not re-read):

| Plugin | Codex version | Skills provided |
|---|---|---|
| `caveman@caveman` | 4.0.1 | same set as the Claude side, unprefixed |
| `ponytail@ponytail` | 5.3.2 | same set as the Claude side, unprefixed |
| `mattpocock-skills@mattpocock` | 1.3.1 | skills live in subfolders (productivity, misc, engineering, …) |
| `claude-mem@claude-mem-local` | 13.41.0 | same set as the Claude side, unprefixed |
| `andrej-karpathy-skills@karpathy-skills` | 1.0.0 | karpathy-guidelines |
| `pstack@cursor-plugins` | 0.15.32 | setup-pstack + workflow/agent skills |
| `superpowers@claude-plugins-official` | 7.0.0 | brainstorming, systematic-debugging, TDD, planning and verification set |

Version drift vs Claude: `pstack` 0.15.29 → 0.15.32 and `superpowers` 6.1.1 → 7.0.0
(Codex installs the latest marketplace release).

### Cached but not enabled

Present in `~/.codex/plugins/cache/` with no `[plugins.*]` entry in `config.toml`
(from the 2026-10-24 snapshot, not re-verified):

- `ecc`. Empty
- `openai-curated-remote`. Google-docs/-drive/-sheets/-slides/-comments, artifact
  report templates, plugin-management, sites-remix, and a bundled copy of the
  superpowers skill set

## Project scope (Playground checkout)

This repository ships six project skills in `.agents/skills/` (canonical,
committed); `.claude/skills/` holds compatibility junctions for Claude only.
What each skill does: [Using the skills](../guides/using-the-skills.md).
Why this layout: [Skill layout](../architecture/skill-layout.md).
