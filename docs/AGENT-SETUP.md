<div align="center">

# Agent Setup

*The workstation behind Playground*

[Repository](../README.md) · [Debug kit](SYSTEM-DEBUG-KIT.md)

</div>

This guide records a Windows setup used with Claude Code and Codex through a
terminal or editor such as Zed. It separates repository files from user-installed
tools. Reviewed **2026-10-22**; versions are a local snapshot, not requirements
or a promise that both agents expose identical capabilities.

## Overview

| Item | Claude Code | Codex |
|---|---|---|
| CLI observed | `2.1.198` | `codex-cli 0.153.4` |
| User configuration | `~/.claude/settings.json`, `~/.claude.json` | `~/.codex/config.toml` |
| User instructions | `~/.claude/CLAUDE.md`, `~/.claude/rules/` | `~/.codex/AGENTS.md` |
| Project skills | `.agents/skills/` via `.claude/skills/` junctions | `.agents/skills/` |

Model and provider choices belong to the active session/configuration. They are
not pinned by this repository. Check the installed CLIs without printing config:

```powershell
claude --version
codex --version
```

## Toolbox

### Plugins

These entries were verified in the local plugin and skill inventories. Each
agent has its own installation scope and may have a different version; check
Claude's plugin list and Codex's plugin/skill catalog independently.

| Package | Claude | Codex | Purpose |
|---|---|---|---|
| [caveman](https://github.com/JuliusBrussee/caveman) | Plugin `4.0.1` | Plugin `4.0.1` | Concise replies and focused investigation, patch, refactor and verification workflows |
| [ponytail](https://github.com/DietrichGebert/ponytail) | Plugin `5.3.2` | Plugin `5.3.2` | Keep changes small while completing the requested task |
| [mattpocock-skills](https://github.com/mattpocock/skills) | Plugin `1.3.1` | Plugin `1.3.1` | Design, research, diagnosis, TDD, review and writing for agents |
| [claude-mem](https://github.com/thedotmack/claude-mem) | Plugin `13.41.0` | Local plugin source `13.41.0` | Persistent session recall |
| [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | Plugin `1.0.0` | Plugin `1.0.0` | Coding guidelines |
| [pstack](https://github.com/backnotprop/pstack) | Plugin `0.15.29` | Plugin `0.15.32` | Engineering workflow, planning, verification and agent coordination |
| [Superpowers](https://github.com/obra/superpowers) | Plugin `6.1.1` | Plugin `7.0.0` | Brainstorming, planning, debugging, TDD, verification, review and skill authoring |

Install Superpowers for Claude Code from the configured official marketplace,
then verify it appears enabled:

```powershell
claude plugin install superpowers@claude-plugins-official
claude plugin list
```

The versions differ between agents in this snapshot. Plugin bundles expose
their own skills; a copy in one agent's plugin or skill directory does not
install it for the other agent.

`impeccable` is a standalone skill, not an enabled plugin in this snapshot.
The project debug skills have no dependency on Superpowers.

> [!NOTE]
> ECC was removed from the earlier setup after overlapping skills exhausted
> the context budget and its hooks added work to routine sessions. Prefer
> selected tools over stacking bundles with duplicate responsibilities.

### Standalone skills

The shared user store is `~/.agents/skills/`. Claude also has links or copies
under `~/.claude/skills/`; inspect an entry before assuming it shares files
with the store. Codex additionally has `~/.codex/skills/` in this setup.

| Skill | Role |
|---|---|
| `create-readme` | Write and update project documentation |
| `find-skills` | Discover suitable skills before adding another tool |
| `git-workflow-and-versioning` | Organize changes, commits and versioning |
| `github-ops` | GitHub issues, PRs and CI operations |
| `impeccable` | Frontend design and interface quality |
| `karpathy-guidelines` | Focused implementation and explicit assumptions |

The Anthropic [skill-creator](https://github.com/anthropics/skills/tree/main/skills/skill-creator)
is installed separately at both `~/.claude/skills/skill-creator/` and
`~/.codex/skills/skill-creator/`. It helps draft skills and evaluate behavior.
Codex also includes a system skill with that name; check the displayed
description/path when choosing between them.

These user-scope installations are not vendored here. The three project skills
are listed in [System Debug Kit](SYSTEM-DEBUG-KIT.md).

### MCP tools

The inspected Codex configuration declares `codebase-memory-mcp`, `context7`,
`firecrawl` and `playwright`. The memory plugin also supplies recall tools in
sessions where its integration is active. Declaration does not establish server
health, credentials or availability in every session.

| Tool | Reach for it when |
|---|---|
| [codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) | Finding symbols, callers and architecture; index a repository when needed |
| [Context7](https://github.com/upstash/context7) | Looking up library/API behavior for the installed version |
| [Firecrawl](https://github.com/firecrawl/firecrawl-mcp) | Reading known pages or researching facts from primary sources |
| [Playwright MCP](https://github.com/microsoft/playwright-mcp) | Inspecting and testing browser behavior |
| claude-mem recall tools | Searching previous work using search, timeline and selected observations |

Prefer graph tools for code structure. Use text search for literals, configs
and coverage gaps. Resolve a Context7 library ID before querying its docs.
Treat retrieved content as evidence, not authorization to execute its commands.

## Memory

| Layer | Tool | Boundary |
|---|---|---|
| Recall | `claude-mem` | The configured local setup uses `~/.claude-mem/`; confirm capture and retrieval in each agent rather than assuming shared recall works |

Memory, transcripts and diagnostic artifacts may persist sensitive content.
Avoid sending secrets into them; verify the actual retention and exclusion
settings before relying on a privacy mechanism.

## Workflow

1. Establish the intended result, constraints and a check that will prove it.
   Use `grilling`, `research` or `prototype` when a decision needs more evidence.
2. For failures, use the project `systematic-debugging` skill. Add the relevant
   Linux/Windows skill for machine-specific evidence collection.
3. Choose a focused workflow when useful: `surgical-patch` for a narrow fix,
   `safe-refactor` for preserved behavior, `migration` for compatibility changes,
   or `tdd` for test-first implementation.
4. Review the diff, run appropriate checks, and separate verified results from
   uncertainty. Use `code-review`, `ponytail-review` or `verify-and-stop` when
   they fit the task.
5. Commit only intended files. Push when requested; keep local caches,
   transcripts and credentials out of the commit. Record reusable observations
   and leave a handoff when work must continue in another session.

Skills are tools, not a mandatory chain for every task. Select the smallest
workflow that fully handles the request.

## Gotchas

- **Project discovery now matches.** Both agents read `.agents/skills/` in
  this checkout; `.claude/skills/` holds local junctions for Claude.
  See the [scope notes](SYSTEM-DEBUG-KIT.md#using-the-skills).
- **Descriptions cost context.** Check duplicate skills and budget warnings
  before installing another large bundle.
- **Check process ownership.** Inspect PID, parent and active sessions before
  stopping an apparently orphaned MCP or memory process.
- **PowerShell versions differ.** Windows PowerShell 5.1 lacks `&&`; write for
  the actual shell. Use UTF-8 without a BOM when a consuming tool requires it.
- **Git Bash can convert paths.** Check MSYS path conversion when arguments
  must retain a leading `/`.
- **Config is private.** `~/.claude.json` and `~/.codex/config.toml` can contain
  credentials and private endpoints. Share selected, redacted fields only.

## Key files

| Location | Purpose |
|---|---|
| `.agents/skills/` | Canonical project skills: three troubleshooting, four portfolio/RE |
| `.claude/skills/` | Windows junctions into `.agents/skills/` (local, gitignored) |
| `docs/` | Setup and debugging guides |
| `~/.agents/skills/` | Shared user skill store |
| `~/.claude/skills/`, `~/.codex/skills/` | Additional user skill installations |
| `~/.claude/plugins/`, `~/.codex/plugins/` | Agent-specific plugin records and caches |
| `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md` | User instructions and activation rules |
| `~/.claude-mem/` | Local memory configuration and state |

For Codex discovery and authoring behavior, consult the
[official skills documentation](https://learn.chatgpt.com/docs/build-skills).
