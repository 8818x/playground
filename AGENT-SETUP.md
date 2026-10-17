<div align="center">

# Agent Setup

*A portable toolkit for coding agents — Claude Code and Codex on Windows, driven through Zed*

[Overview](#overview) • [Toolbox](#toolbox) • [Memory](#memory) • [Workflow](#workflow) • [Gotchas](#gotchas)

</div>

This repository is a **field kit**: the plugins, skills and MCP servers I carry between machines, documented so Claude Code and Codex share one identical setup and work swaps sides without re-learning anything.

> [!NOTE]
> A snapshot of one machine — not an installer or dotfiles.  
> Last reviewed: **2026-10-17**

## Overview

| | Claude Code | Codex |
|---|---|---|
| CLI | `2.1.198` | `codex-cli 0.153.4` |
| Provider / Model | Z.ai GLM: `glm-5.3-flash`, effort `max` | `gpt-6.1-sol`, reasoning `medium` · `gpt-6-lunamax` |
| Main config | `~/.claude/settings.json`, `~/.claude.json`, `~/.claude/rules/` | `~/.codex/config.toml`, `~/.codex/AGENTS.md` |

Check current state:

```bash
claude --version
codex --version
claude plugin list
codex plugin list
claude mcp list
codex mcp list
```

## Toolbox

### Plugins

Both agents read the same marketplace format (`.claude-plugin/marketplace.json` or `.agents/plugins/`), so one repo ships to both. Versions are kept in sync deliberately.

| Plugin | Scope | Version | What it does |
|---|---|---|---|
| [`caveman`][cav] | Claude + Codex | `4.0.1` | Terse replies plus focused workflows: `investigate-first`, `surgical-patch`, `safe-refactor`, `migration`, `lean-build`, `verify-and-stop` |
| [`ponytail`][pony] | Claude + Codex | `5.3.2` | Forces the shortest working path: YAGNI, stdlib first, no over-engineering |
| [`mattpocock-skills`][mp] | Claude + Codex | `1.3.1` | `grilling`, `grill-with-docs`, `tdd`, `code-review`, `research`, `prototype`, `diagnosing-bugs`, `domain-modeling`, `codebase-design`, `handoff`, `writing-for-agents`, `improve-codebase-architecture` |
| [`claude-mem`][cmem] | Claude + Codex | `13.41.0` | Persistent memory: hooks capture every session, AI-compressed observations, semantic recall via the `mcp-search` MCP server — shared database across both agents |
| [`andrej-karpathy-skills`][karp] | Claude (Codex gets the same skill via the skills store) | `1.0.0` | `karpathy-guidelines` — think before coding, simplicity first, surgical changes, verifiable goals |
| [`impeccable`][impecc] | Claude + Codex | skill `4.6.0`, engine `0.1.15` | Design expertise: ~30 commands (`polish`, `typeset`, `critique`, `audit`), a 59-check AI-slop detector, `PRODUCT.md`/`DESIGN.md` project context, local design hooks |

```bash
claude plugin update <name>@<marketplace>
codex plugin add <name>@<marketplace>   # install on the Codex side
```

> [!WARNING]
> **History — why ECC was removed (2026-10-17).** [`ecc`][ecc] v2.2.x shipped ~280 skills, ~88 agents and lifecycle hooks. Stacking it with cherry-picked standalone skills overflowed the skills budget and broke skill routing, and a full-bundle install worked only while nothing duplicated it. The harness-wide hook gating (GateGuard fact-forcing on every Bash call) also taxed routine work. ECC has been uninstalled from both agents — plugin, marketplace and cache. Keep the lesson: the skills budget pays for the *whole* load; a heavy plugin means not stacking duplicates from the same source, and every always-on hook is a tax paid on every session.

### Standalone skills

Global store at `~/.agents/skills/` installed with the [skills CLI][npxskills]. Claude uses symlinks from `~/.claude/skills/`; Codex reads the store directly. One install serves every supported agent.

| Skill | Source | Use when |
|---|---|---|
| `create-readme` | [github/awesome-copilot][gh] | Generate or update a project README |
| `find-skills` | [vercel-labs/skills][npxskills] | Standing meta-skill — asks the registry when you say "find a skill for X" |
| `task-observer` | [rebelytics/one-skill-to-rule-them-all][tso] | Watches sessions for corrections and repeated work, proposes skill improvements in `skill-updates/` for review |
| `karpathy-guidelines` | [multica-ai/andrej-karpathy-skills][karp] | Keep code simple, readable and verifiable — standing style guard (store copy serves Codex; Claude loads the plugin) |

`impeccable` also lives in the store (`~/.agents/skills/impeccable`) with its own copy for Claude — see the plugin table.

```bash
npx skills add <owner>/<repo> --skill <name> -g
npx skills update
```

### MCP servers

| Server | Agents | Command | What it does | Auth |
|---|---|---|---|---|
| [`codebase-memory-mcp`][cbm] | Claude + Codex | local executable (v0.12.1) | Indexes code into a graph — structure search, call tracing, impact analysis | — |
| [`firecrawl`][fc] | Claude + Codex | `npx -y firecrawl-mcp` | Web search, scraping, crawling, structured research | `FIRECRAWL_API_KEY` |
| [`context7`][c7] | Claude + Codex | `npx -y @upstash/context7-mcp` | Version-matched library documentation | `CONTEXT7_API_KEY` |
| [`playwright`][pw] | Claude + Codex | `npx -y @playwright/mcp@latest --browser msedge` | Browser control, E2E, screenshots | — |
| `web_reader` | Claude only | `mcp__web_reader__webReader` | Single-URL → markdown reader, lighter than a full scrape | — |
| `mcp-search` | Claude + Codex | via `claude-mem` plugin | 3-layer memory search: `search` → `timeline` → `get_observations` | — |

> [!TIP]
> Reach for [`codebase-memory-mcp`][cbm] before `grep` when hunting symbols, callers or architecture. Keep `grep` for literals, config and files the graph does not cover. Both agents carry the same instruction block with the tool priority order (`search_graph` → `trace_path` → `get_code_snippet` → `query_graph` → `get_architecture`) and worked examples — Claude in `~/.claude/rules/mcp-selection.md`, Codex in `~/.codex/AGENTS.md`.

Add an MCP server on the Codex side:

```bash
codex mcp add <name> --env KEY=VALUE -- <command>
```

## Memory

Two complementary layers, both installed on 2026-10-17:

| Layer | Plugin | Job |
|---|---|---|
| **Recall** | [`claude-mem`][cmem] | Captures everything both agents do, compresses it into observations, injects relevant context at session start. Shared storage in `~/.claude-mem` (SQLite + vector search), so Claude remembers what Codex did and vice versa |
| **Improvement** | `task-observer` [one-skill-to-rule-them-all][tso] | Reads sessions for corrections, repeated manual work and skill blind spots; writes structured proposals to `skill-updates/` — nothing changes until reviewed and approved |

claude-mem needs no interaction; check health with `npx claude-mem doctor`. To let a session start pull observations from *both* harnesses, set `"CLAUDE_MEM_SESSION_START_INCLUDE_ALL_SOURCES": "true"` in `~/.claude-mem/settings.json` (created on first run).

task-observer is **not** self-activating: an activation block lives in `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md` (wrapped in `<!-- task-observer:start/end -->` markers). It works only if `skill-observations/observation-log/` appears during real work — absence means activation failed.

## Workflow

### 1. Pick a lane before touching code

| Situation | Start with |
|---|---|
| Requirements unclear | [`grilling`][mp] — walk decisions as a design tree; [`grill-with-docs`][mp] when ADRs/glossary should be written along the way |
| Unsure it is feasible | [`prototype`][mp] — throwaway check before committing |
| Facts / comparisons needed before deciding | [`research`][mp] — evidence-first with citations |
| Discussion settled, need the artifact | spec or tickets via `mattpocock-skills` |
| Feasibility settled | Enter a pipeline below |

### 2. Pick the pipeline that matches the job

| Job | Pipeline |
|---|---|
| Small bug / cause already narrow | [`investigate-first`][cav] then [`surgical-patch`][cav] |
| Hard or recurring bug | [`diagnosing-bugs`][mp] |
| Behavior-preserving refactor | [`safe-refactor`][cav] |
| Feature at risk of scope creep | [`lean-build`][cav] |
| Migration needing rollback | [`migration`][cav] |
| Test-first feature work | [`tdd`][mp] |
| Designing a module's interface or seam | [`codebase-design`][mp] · [`domain-modeling`][mp] |
| Work too big for one session | [`wayfinder`][mp] — decision-ticket map, resolve one at a time |
| Tiny task | Do it directly, [`ponytail`][pony] keeps scope honest |

### 3. While working (every lane)

- Structure, callers, impact → [`codebase-memory-mcp`][cbm] before `grep`
- Version-sensitive APIs → [`context7`][c7] before writing
- Web facts or pages → `web_reader` (known URL) / `firecrawl` (unknown)
- Merge/rebase conflict in progress → [`resolving-merge-conflicts`][mp]
- New repo or stale README → [`create-readme`][gh]

### 4. Before shipping

1. [`code-review`][mp] on every diff (or the built-in `/code-review` for bug-hunting levels)
2. [`simplify`] for reuse and efficiency cleanups
3. [`ponytail-review`][pony] when over-engineering is a risk
4. built-in `security-review` when touching auth, input or secrets
5. [`verify-and-stop`][cav] as the final gate
6. [`pr`][mp] — PR body from the current diff

### 5. End of session

- [`handoff`][mp] — compress the conversation into a handoff doc another agent can pick up
- claude-mem has already captured the session; task-observer's log feeds the next skill review — ask "Any observations logged?" at session end

### 6. The rest of the kit (situational)

| Skill | When |
|---|---|
| [`improve-codebase-architecture`][mp] | Periodic deepening scan → HTML report → grill the pick |
| [`ponytail-audit`][pony] | Whole-repo over-engineering audit, one-shot report |
| [`ask-matt`][mp] | Router — "which of these skills fits my situation?" |
| [`wait-what`][mp] | Last answer did not land — force a re-pitch |
| [`to-questionnaire`][mp] | Turn an unanswerable decision into a questionnaire |
| [`writing-for-agents`][mp] | When writing or editing skills / AGENTS.md |
| `/impeccable polish|critique|audit` | UI work — see the [plugin table](#plugins) |
| `find-skills` | Anything the kit does not cover yet — search the registry |

## Repo conventions

These files help agents understand a project the way the team does:

| File | Modelled after | Purpose |
|---|---|---|
| `AGENTS.md` | per repository | Instructions, boundaries and workflow for agents |
| `DESIGN.md` | [`impeccable`][impecc] / [google-labs-code/design.md][gdesign] | Design tokens and the reasoning behind UI choices |
| `GLOSSARY.md` | [GoogleCloudPlatform/scion][scion] | Domain vocabulary and team-agreed meanings |

Create only the files a project actually needs, filled with that project's real content.

## Gotchas

1. **One MCP process per session** — close unused Zed tabs to avoid orphaned processes. Codex multi-agent threads leak `codebase-memory-mcp.exe` instances; sweep periodically:

   ```powershell
   Get-CimInstance Win32_Process -Filter "Name = 'codebase-memory-mcp.exe'" |
     Select-Object ProcessId, ParentProcessId, CreationDate
   ```

2. **Skills budget is finite** — every session loads every skill description. Before adding another big plugin or standalone skill, check the load does not return the `Exceeded skills context budget` warning. The current kit fits comfortably; ECC did not.
3. **claude-mem runs a background worker** (Bun-based) plus hooks on every tool event. First run creates `~/.claude-mem/settings.json`; wrap sensitive content in `<private>` tags to keep it out of storage.
4. **task-observer needs its activation block** — installing the skill alone under-triggers. If `skill-observations/observation-log/` never appears, the block in `~/.claude/CLAUDE.md` / `~/.codex/AGENTS.md` was lost.
5. **Git Bash rewrites paths** — prefix `MSYS_NO_PATHCONV=1` when an argument starting with `/` must survive intact.
6. **Windows PowerShell 5.1 lacks `&&`** — use `;`, PowerShell 7 or Git Bash.
7. **API keys sit in plaintext** in `~/.claude.json` and `~/.codex/config.toml`.

> [!CAUTION]
> Before sharing any config, strip tokens, API keys, private endpoints and user-identifying paths.

## Key files

```text
~/.claude/settings.json           provider, model mapping, plugins, statusline
~/.claude/CLAUDE.md               user-scope instructions (task-observer activation)
~/.claude/rules/                  MCP selection, orchestration, skill routing
~/.claude/projects/<proj>/memory  durable per-project auto-memory (MEMORY.md)
~/.claude/plugins/cache/          installed plugins
~/.claude/skills/                 symlinks into the shared skill store
~/.codex/config.toml              Codex plugins, MCP, sandbox and hooks
~/.codex/AGENTS.md                Codex user-scope instructions (same blocks)
~/.agents/skills/                 central standalone-skill store (shared)
~/.claude-mem/                    claude-mem database, settings and worker state
```

## Link definitions

Every external reference in this file is a reference-style link defined here:

<!-- reference-style link definitions -->
[cav]: https://github.com/JuliusBrussee/caveman
[mp]: https://github.com/mattpocock/skills
[pony]: https://github.com/DietrichGebert/ponytail
[ecc]: https://github.com/affaan-m/ECC
[cmem]: https://github.com/thedotmack/claude-mem
[gh]: https://github.com/github/awesome-copilot
[karp]: https://github.com/multica-ai/andrej-karpathy-skills
[tso]: https://github.com/rebelytics/one-skill-to-rule-them-all
[impecc]: https://impeccable.style
[npxskills]: https://github.com/vercel-labs/skills
[cbm]: https://github.com/DeusData/codebase-memory-mcp
[c7]: https://github.com/upstash/context7
[fc]: https://github.com/firecrawl/firecrawl-mcp
[pw]: https://github.com/microsoft/playwright-mcp
[gdesign]: https://github.com/google-labs-code/design.md
[scion]: https://github.com/GoogleCloudPlatform/scion/blob/main/GLOSSARY.md
