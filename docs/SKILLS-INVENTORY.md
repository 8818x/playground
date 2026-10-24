# Skills Inventory

Agent skills installed at **user scope**, split by source, for Claude Code and Codex.
Snapshot date: 2026-10-24.

## Claude Code (`~/.claude`)

### From plugins (7)

All installed with `scope: user` (see `~/.claude/plugins/installed_plugins.json`).
Plugin skills appear namespaced as `plugin:skill-name` in the session skill list.

| Plugin | Version | Skills provided |
|---|---|---|
| `superpowers@claude-plugins-official` | 6.1.1 | brainstorming, systematic-debugging, test-driven-development, writing-plans, executing-plans, subagent-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, requesting-code-review, receiving-code-review, finishing-a-development-branch, writing-skills, dispatching-parallel-agents |
| `ponytail@ponytail` | 5.3.2 | ponytail, ponytail-audit, ponytail-debt, ponytail-gain, ponytail-help, ponytail-review |
| `caveman@caveman` | 4.0.1 | caveman, caveman-init, caveman-commit, caveman-compress, caveman-discover, caveman-evidence-review, caveman-explore, caveman-help, caveman-learn, caveman-manage, caveman-optimize, caveman-review, caveman-setup, caveman-stats, investigate-first, lean-build, migration, safe-refactor, surgical-patch, verify-and-stop, cavecrew (agents: cavecrew-builder, cavecrew-investigator, cavecrew-reviewer) |
| `mattpocock-skills@mattpocock` | 1.3.1 | tdd, code-review, pr, prototype, research, domain-modeling, codebase-design, diagnosing-bugs, grilling, wizard, writing-for-agents |
| `claude-mem@thedotmack` | 13.41.0 | mem-search, make-plan, do, build, release, babysit, handoff, learn-codebase, smart-explore, pathfinder, standup, how-it-works, knowledge-agent, timeline-report, weekly-digests, mode-creator, cloud-sync, screenpipe, ccs-align, oh-my-issues, version-bump, build-and-release, childhood, design-is, agent-cost-report, what-the, wowerpoint |
| `pstack@cursor-plugins` | 0.15.29 | setup-pstack (agents: poteto-agent, comment-sicko) |
| `andrej-karpathy-skills@karpathy-skills` | 1.0.0 | karpathy-guidelines |

### Standalone user-scope skills (`~/.claude/skills/`, 12)

codebase-memory, create-readme, find-skills, git-workflow-and-versioning,
github-ops, hyperframes, hyperframes-cli, hyperframes-registry, impeccable,
media-use, skill-creator, task-observer

### Built-in Claude Code skills (bundled, not plugins)

claude-api, code-review, dataviz, fewer-permission-prompts, init,
keybindings-help, loop, plugin-authoring, run, security-review, simplify,
update-config, workflow-authoring

## Codex (`~/.codex`)

### Standalone user-scope skills (`~/.codex/skills/`, 1)

skill-creator

`jd-to-portfolio-tutor` moved to Playground project scope (see below).

### From plugins (7, registered in `config.toml`)

Same set as the Claude side. Skills ship without a namespace prefix on Codex.

| Plugin | Codex version | Skills provided |
|---|---|---|
| `caveman@caveman` | 4.0.1 | same set as the Claude side, unprefixed |
| `ponytail@ponytail` | 5.3.2 | ponytail, ponytail-audit, ponytail-debt, ponytail-gain, ponytail-help, ponytail-review |
| `mattpocock-skills@mattpocock` | 1.3.1 | skills live in subfolders (productivity, misc, engineering, …) |
| `claude-mem@claude-mem-local` | 13.41.0 | same set as the Claude side, unprefixed |
| `andrej-karpathy-skills@karpathy-skills` | 1.0.0 | karpathy-guidelines |
| `pstack@cursor-plugins` | 0.15.32 | setup-pstack + workflow/agent skills |
| `superpowers@claude-plugins-official` | 7.0.0 | brainstorming, systematic-debugging, TDD, planning and verification set |

Version drift vs Claude: `pstack` 0.15.29 → 0.15.32 and `superpowers` 6.1.1 → 7.0.0
(Codex installs the latest marketplace release).

### Cached but not enabled

Present in `~/.codex/plugins/cache/` with no `[plugins.*]` entry in `config.toml`:

- `ecc` — empty
- `openai-curated-remote` — google-docs/-drive/-sheets/-slides/-comments, artifact
  report templates, plugin-management, sites-remix, and a bundled copy of the
  superpowers skill set

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
