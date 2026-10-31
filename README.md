# Playground

*An agent toolkit for Claude Code and Codex on Windows: seven installed
plugins first, six bundled skills as the bonus.*

[Get started](#quick-start) | [Plugin toolkit](#plugin-toolkit) | [Bundled skills](#bundled-skills) | [Documentation](#documentation)

Playground documents one working agent setup. The plugin toolkit is the main
toolbox; the bundled project skills are the bonus layer for investigating
software bugs and Linux or Windows incidents.

> [!NOTE]
> This repository records a machine-specific setup; it is not an installer.
> Cloning it does not install plugins, configure credentials, or start services.

## What this repository contains

- The plugin toolkit: seven plugins, 167 skills, installed for both Claude
  Code and Codex. See the
  [Plugin skills guide](docs/reference/plugin-skills.md).
- Bonus: 6 self-contained skills in `.agents/skills/` (canonical, committed),
  three troubleshooting and three portfolio.
- Documentation under `docs/`: setup, guides, workflows, architecture, reference.

## Quick start

1. Open this repository in your terminal or editor.
2. Read [Agent Setup](docs/setup/agent-setup.md) to see the tools, plugins, and
   skills the agent starts with.
3. Browse the [Plugin skills guide](docs/reference/plugin-skills.md) and
   invoke a plugin skill by name, or read
   [Using the skills](docs/guides/using-the-skills.md) for the bundled ones.
4. Brief the agent as those docs describe.

Example requests:

```text
Use the superpowers brainstorming skill before we design the new importer.
```

```text
Read .agents/skills/linux-troubleshooting/SKILL.md and check why port 443
refuses connections on this server. Diagnosis only.
```

Claude Code discovers project skills in `.claude/skills/`; Codex discovers
`.agents/skills/`.

## Plugin toolkit

The main toolbox. Seven plugins cover process discipline, persistent memory,
terse replies, planning and design vocabulary, and engineering workflow:

| Plugin | What it adds |
|---|---|
| superpowers | Brainstorm, plan, TDD, verify: the disciplined process |
| claude-mem | Persistent memory across sessions |
| pstack | Named principles, parallel workers, verification generators |
| mattpocock-skills | Planning, diagnosis and code-design vocabulary |
| caveman | Token-saving terse modes and cost tooling |
| ponytail | Smallest-change mode with one-pass readable replies |
| andrej-karpathy-skills | Surgical-change coding guidelines |

Every skill explained in plain words:
[Plugin skills guide](docs/reference/plugin-skills.md). Versions and counts:
[Skills inventory](docs/reference/skills-inventory.md).

## Bundled skills

The bonus layer. Three committed troubleshooting skills:

| Skill | Use it for |
|---|---|
| [systematic-debugging](.agents/skills/systematic-debugging/SKILL.md) | Bugs, failing tests, integration errors, intermittent behavior, and performance regressions |
| [linux-troubleshooting](.agents/skills/linux-troubleshooting/SKILL.md) | Linux resource pressure, services, HTTP, SSH, networking, and deployments |
| [windows-troubleshooting](.agents/skills/windows-troubleshooting/SKILL.md) | Windows crashes, slowness, storage, services, drivers, updates, and connectivity |

Each troubleshooting skill includes scenario prompts under `evals/evals.json`
for reviewing its decisions. The three portfolio skills are covered in
[Using the skills](docs/guides/using-the-skills.md), together with usage
limits.

## Agent compatibility

Canonical project skills live in `.agents/skills/`. Claude Code uses
junctions under `.claude/skills/` pointing at the same directories. Reasoning and
discovery details: [Skill layout](docs/architecture/skill-layout.md).

## Documentation

Start with the [Plugin skills guide](docs/reference/plugin-skills.md), then
[Agent Setup](docs/setup/agent-setup.md).

### Setup

- [Agent Setup](docs/setup/agent-setup.md) covers the workstation tools,
  plugins, memory and workflow

### Guides

- [Using the skills](docs/guides/using-the-skills.md) covers choosing a skill,
  briefing the agent and usage limits

### Workflows

- [Skill development](docs/workflows/skill-development.md) explains changing a
  project skill safely

### Architecture

- [Skill layout](docs/architecture/skill-layout.md) explains the one canonical
  copy and its compatibility junctions

### Reference

- [Plugin skills guide](docs/reference/plugin-skills.md) describes every skill
  inside the seven installed plugins in plain language
- [Skills inventory](docs/reference/skills-inventory.md) lists every installed
  user-scope skill for Claude and Codex, split by source

### History

- [History](docs/history/README.md) — removals and decisions, with reasons

## Repository layout

```text
playground/
├── .agents/skills/     canonical project skills ×6 (Codex discovery)
├── .claude/skills/     junctions into .agents/skills (gitignored, local only)
├── docs/
│   ├── setup/          agent-setup.md
│   ├── guides/         using-the-skills.md
│   ├── workflows/      skill-development.md
│   ├── architecture/   skill-layout.md
│   └── reference/      skills-inventory.md, plugin-skills.md
├── LICENSE
└── README.md
```

> [!CAUTION]
> Setup notes and diagnostic artifacts can contain personal data. Review and
> redact them before sharing, and keep credentials out of this repository.
