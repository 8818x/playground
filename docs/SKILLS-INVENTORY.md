# Skills Inventory

Agent skills installed at **user scope**, split by source, for Claude Code and Codex.
Snapshot date: 2026-10-29.

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
| `caveman@caveman` | 4.0.1 | caveman, caveman-commit, caveman-compress, caveman-discover, caveman-evidence-review, caveman-explore, caveman-help, caveman-learn, caveman-manage, caveman-optimize, caveman-review, caveman-setup, caveman-stats, cavecrew, megacave, ultracave, investigate-first, lean-build, migration, safe-refactor, surgical-patch, verify-and-stop — `caveman-init` ships as a command, not a skill (agents: cavecrew-builder, cavecrew-investigator, cavecrew-reviewer) |
| `mattpocock-skills@mattpocock` | 1.3.1 | 38 skills: ask-matt, chief-of-staff, claude-handoff, code-review, codebase-design, diagnosing-bugs, domain-modeling, git-guardrails-claude-code, grill-me, grill-with-docs, grilling, handoff, implement, implement-spec, improve-codebase-architecture, loop-me, migrate-to-shoehorn, pr, prototype, research, retro, scaffold-exercises, setup-matt-pocock-skills, setup-pre-commit, setup-ts-deep-modules, tdd, teach, to-questionnaire, to-spec, to-tickets, triage, wait-what, wayfinder, wizard, writing-beats, writing-fragments, writing-for-agents, writing-shape |
| `ponytail@ponytail` | 5.3.2 | ponytail, ponytail-audit, ponytail-debt, ponytail-gain, ponytail-help, ponytail-review |
| `andrej-karpathy-skills@karpathy-skills` | 1.0.0 | karpathy-guidelines |

### Standalone user-scope skills (`~/.claude/skills/`, 11 live)

Nine plain directories: codebase-memory, git-workflow-and-versioning, github-ops,
hyperframes, hyperframes-cli, hyperframes-registry, impeccable, media-use,
skill-creator. Two junctions into the shared store: create-readme, find-skills →
`~/.agents/skills/<name>`.

The `task-observer` junction was broken (store folder deleted) and was removed
on 2026-10-29.

### Built-in Claude Code skills (bundled, not plugins)

claude-api, code-review, dataviz, fewer-permission-prompts, init,
keybindings-help, loop, plugin-authoring, run, security-review, simplify,
update-config, workflow-authoring

## Shared skill store (`~/.agents/skills/`, 72)

Plain directories read directly by QwenWork and other harnesses; Claude Code
consumes entries selectively via links in `~/.claude/skills/`. Families:
`principle-*` (24), the poteto stack, the hyperframes trio, plus dev-loop,
swarm, technical-writing, unslop and others. Several names duplicate
plugin-provided skills (pstack, mattpocock); the store holds independent
copies.

## Codex (`~/.codex`)

### Standalone user-scope skills (`~/.codex/skills/`)

- `skills/skill-creator/` — user-installed
- `skills/.system/` — five built-in system skills: imagegen, openai-docs,
  review-agent, skill-creator (system), skill-installer

Skills load by convention from `$CODEX_HOME/skills`; `config.toml` has no
`[skills]` section, and `.system/` is reserved for Codex's own skills.

`jd-to-portfolio-tutor` moved to Playground project scope (see below).

### From plugins (7, registered in `config.toml`, all enabled)

Same marketplaces as the Claude side. Skills ship without a namespace prefix
on Codex. Cache re-checked 2026-10-30 against `~/.codex/plugins/cache/` and
`config.toml`.

| Plugin | Codex version | Skills provided |
|---|---|---|
| `caveman@caveman` | 4.0.1 | same set as the Claude side (22), unprefixed |
| `ponytail@ponytail` | 5.3.3 | same set as the Claude side (6), unprefixed |
| `mattpocock-skills@mattpocock` | 1.3.2 | same set as the Claude side (38), unprefixed |
| `claude-mem@claude-mem-local` | 15.3.0 | same set as the Claude side (30), unprefixed; `claude-mem@thedotmack` is registered but disabled |
| `andrej-karpathy-skills@karpathy-skills` | 1.0.0 | karpathy-guidelines |
| `pstack@cursor-plugins` | 0.15.36 | Claude set (56) plus `ketchup-video` and `statechart` |
| `superpowers@claude-plugins-official` | 7.0.0 | Claude set (14) plus `diagnosing-superpowers` |

Version drift vs Claude: `ponytail` 5.3.2 -> 5.3.3, `mattpocock-skills` 1.3.1 ->
1.3.2, `pstack` 0.15.29 -> 0.15.36, `superpowers` 6.1.1 -> 7.0.0 (Codex installs
the latest marketplace release). claude-mem differs by source: Codex runs the
local-source plugin at 15.3.0, Claude runs the fork build at 15.5.0.

### Cached but not enabled

Present in `~/.codex/plugins/cache/` with no enabled `[plugins.*]` entry
(re-checked 2026-10-30):

- `openai-curated-remote` - google-drive (5), openai-templates (20 artifact
  templates), plugin-management (1), sites + sites-remix (2), work-pets (3),
  and its own superpowers 7.0.1 copy (15)
- `ecc` - empty

## Project scope (Playground checkout)

The project skill suite lives in this repo at `.agents/skills/` (canonical,
committed) — three troubleshooting skills plus four portfolio/RE skills.
`.claude/skills/` holds Windows junctions to them (gitignored, local
convenience only); Codex discovers `.agents/skills/` natively, so it needs
no link.

| Skill | In plain words |
|---|---|
| jd-to-portfolio-tutor | Learn a tool or stack from a job description by building a guided portfolio project with checkpoints |
| job-description-analyzer | Score a job posting against your skills, find gaps, plan the application |
| portfolio-case-study-writer | Turn resume bullets into detailed portfolio case studies |
| reverse-engineer-anything | Decompile and explain shipped software (native, Electron, firmware) with REA |
