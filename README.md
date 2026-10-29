# Playground

*Troubleshooting skills and setup notes for Claude Code and Codex on Windows.*

[Get started](#quick-start) | [Troubleshooting skills](#troubleshooting-skills) | [Documentation](#documentation)

Playground collects seven project skills and notes about one working agent
setup. Use the skills to investigate software bugs and Linux or Windows
incidents, or for portfolio and reverse-engineering work.

> [!NOTE]
> This repository records a machine-specific setup; it is not an installer.
> Cloning it does not install plugins, configure credentials, or start services.

## What this repository contains

- Seven self-contained skills in `.agents/skills/` (canonical, committed):
  three troubleshooting skills and four portfolio/reverse-engineering skills.
- Documentation under `docs/`: setup, guides, workflows, architecture, reference.

## Quick start

1. Open this repository in your terminal or editor.
2. Read [Agent Setup](docs/setup/agent-setup.md) to see the tools, plugins, and
   skills the agent starts with.
3. Read [Using the skills](docs/guides/using-the-skills.md) and choose a skill
   for the incident.
4. Brief the agent as [Using the skills](docs/guides/using-the-skills.md)
   describes.

Example request:

```text
Read .agents/skills/linux-troubleshooting/SKILL.md and check why port 443
refuses connections on this server. Diagnosis only.
```

Claude Code discovers project skills in `.claude/skills/`; Codex discovers
`.agents/skills/`.

## Troubleshooting skills

| Skill | Use it for |
|---|---|
| [systematic-debugging](.agents/skills/systematic-debugging/SKILL.md) | Bugs, failing tests, integration errors, intermittent behavior, and performance regressions |
| [linux-troubleshooting](.agents/skills/linux-troubleshooting/SKILL.md) | Linux resource pressure, services, HTTP, SSH, networking, and deployments |
| [windows-troubleshooting](.agents/skills/windows-troubleshooting/SKILL.md) | Windows crashes, slowness, storage, services, drivers, updates, and connectivity |

Each skill includes scenario prompts under `evals/evals.json` for reviewing its
decisions. Usage limits are covered in
[Using the skills](docs/guides/using-the-skills.md#limits), which also lists
the four portfolio skills.

## Agent compatibility

Canonical project skills live in `.agents/skills/`. Claude Code uses
junctions under `.claude/skills/` pointing at the same directories. Reasoning and
discovery details: [Skill layout](docs/architecture/skill-layout.md).

## Documentation

### Setup

- [Agent Setup](docs/setup/agent-setup.md) — the workstation behind Playground:
  tools, plugins, memory, workflow

### Guides

- [Using the skills](docs/guides/using-the-skills.md) — choosing a skill,
  briefing the agent, usage limits

### Workflows

- [Skill development](docs/workflows/skill-development.md) — changing a project
  skill safely

### Architecture

- [Skill layout](docs/architecture/skill-layout.md) — why one canonical copy
  plus compatibility junctions

### Reference

- [Skills inventory](docs/reference/skills-inventory.md) — every installed
  user-scope skill for Claude and Codex, split by source
- [Plugin skills guide](docs/reference/plugin-skills.md) — plain-language
  description of every skill inside the seven installed plugins

## Repository layout

```text
playground/
├── .agents/skills/     canonical project skills ×7 (Codex discovery)
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
