<div align="center">

<img src="assets/toolkittens-logo.png" alt="Toolkit(ten)s" width="220" />

# Toolkit(ten)s

*A portable field kit for coding agents — Claude Code and Codex on one shared setup*

[Overview](#overview) • [Memory](#memory) • [Docs](#docs) • [Workflow](#workflow) • [Gotchas](#gotchas)

</div>

Toolkit(ten)s documents one machine's agent setup as a kit you can carry: plugins, skills and MCP servers wired identically into **Claude Code** and **Codex** (driven through Zed), so work swaps agents without re-learning anything.

> [!NOTE]
> A snapshot of a real machine — not an installer or dotfiles.  
> Last reviewed: **2026-10-17**

## Overview

| | Claude Code | Codex |
|---|---|---|
| CLI | `2.1.198` | `codex-cli 0.153.4` |
| Provider / Model | Z.ai GLM: `glm-5.3-flash`, effort `max` | `gpt-6.1-sol`, reasoning `medium` · `gpt-6-luna`, reasoning `max` |
| Main config | `~/.claude/settings.json`, `~/.claude.json`, `~/.claude/rules/` | `~/.codex/config.toml`, `~/.codex/AGENTS.md` |

**What rides in the kit**

- **6 plugins** — [caveman][cav] (terse mode + focused fix workflows), [ponytail][pony] (shortest working path), [mattpocock-skills][mp] (grilling, TDD, review, planning), [claude-mem][cmem] (persistent memory shared across both agents), [andrej-karpathy-skills][karp] (standing style guard), [impeccable][impecc] (design expertise + AI-slop detector)
- **4 standalone skills** — [create-readme][gh], [find-skills][npxskills], [task-observer][tso] and [karpathy-guidelines][karp] (Codex's copy) via the `skills` CLI, one store shared by every agent
- **6 MCP servers** — [codebase-memory-mcp][cbm] (code graph), [context7][c7] (version-matched docs), [firecrawl][fc] (web research), [playwright][pw] (browser control), `web_reader` (light single-page read, Claude only), `mcp-search` (memory recall via claude-mem)
- **1 debug kit** — troubleshooting skills this repo carries in `.claude/skills/`

> [!WARNING]
> **ECC left the kit.** The [ECC][ecc] full harness (~280 skills, ~88 agents, gated pipelines) overflowed the skills budget when stacked and its always-on hooks taxed every session — removed from both agents. The lesson is recorded in [AGENT-SETUP.md](AGENT-SETUP.md#plugins).

## Memory

Two layers added on 2026-10-17:

- **Recall** — [claude-mem][cmem] captures both agents' sessions into one shared store (`~/.claude-mem`), compresses them into observations, and injects relevant context at session start. Claude remembers what Codex did, and vice versa.
- **Improvement** — [task-observer][tso] watches sessions for corrections and repeated work, then proposes skill updates in `skill-updates/` for human review. Nothing changes until approved.

## Docs

| File | Contents |
|---|---|
| [AGENT-SETUP.md](AGENT-SETUP.md) | The full kit: plugins, skills, MCP servers, memory layers, config files, gotchas |
| [SYSTEM-DEBUG-KIT.md](SYSTEM-DEBUG-KIT.md) | The repo-carried troubleshooting skills (systematic debugging, Linux/Windows triage) |

## Workflow

The short version — full lanes and pipelines in [AGENT-SETUP.md](AGENT-SETUP.md#workflow):

```
1. Pick a lane      grilling · prototype · research · tdd
2. Pick a pipeline  investigate-first → surgical-patch · safe-refactor · lean-build · migration
3. While working    codebase-memory before grep · context7 before APIs · firecrawl for web facts
4. Before shipping  code-review → simplify → ponytail-review → security-review → verify-and-stop
5. End of session   handoff (→ Codex) · claude-mem already captured · task-observer log
```

## Gotchas

The machine-specific traps (MCP process leaks, skills budget, claude-mem background worker, task-observer activation, Windows path quirks) live in [AGENT-SETUP.md](AGENT-SETUP.md#gotchas).

> [!CAUTION]
> Config files referenced by this kit contain plaintext API keys. Never share `~/.claude.json` or `~/.codex/config.toml`.

## Link definitions

<!-- reference-style link definitions -->
[cav]: https://github.com/JuliusBrussee/caveman
[mp]: https://github.com/mattpocock/skills
[pony]: https://github.com/DietrichGebert/ponytail
[ecc]: https://github.com/affaan-m/ECC
[cmem]: https://github.com/thedotmack/claude-mem
[tso]: https://github.com/rebelytics/one-skill-to-rule-them-all
[impecc]: https://impeccable.style
[gh]: https://github.com/github/awesome-copilot
[karp]: https://github.com/multica-ai/andrej-karpathy-skills
[npxskills]: https://github.com/vercel-labs/skills
[cbm]: https://github.com/DeusData/codebase-memory-mcp
[c7]: https://github.com/upstash/context7
[fc]: https://github.com/firecrawl/firecrawl-mcp
[pw]: https://github.com/microsoft/playwright-mcp
