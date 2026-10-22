# Playground

*Troubleshooting skills and setup notes for Claude Code and Codex on Windows.*

[Get started](#get-started) | [Troubleshooting skills](#troubleshooting-skills) | [Documentation](#documentation)

Playground collects three project-local troubleshooting skills and notes about
one working agent setup. Use the skills to investigate software bugs and Linux
or Windows incidents, and the guides to understand the surrounding tools and
workflow.

> [!NOTE]
> This repository records a machine-specific setup; it is not an installer.
> Cloning it does not install plugins, configure credentials, or start services.

## Get started

1. Open this repository in your terminal or editor.
2. Read the [System Debug Kit](docs/SYSTEM-DEBUG-KIT.md) and choose a skill for
   the incident.
3. Give the agent the symptom, affected target, evidence, and allowed actions.
   Start with diagnosis when the cause is unknown.

Claude Code discovers project skills in `.claude/skills/`. For Codex, ask it to
read the relevant `SKILL.md` explicitly; this repository does not include a
project `.agents/skills/` directory.

Example request:

```text
Read .claude/skills/windows-troubleshooting/SKILL.md and investigate this PC's
intermittent application crashes. Collect read-only evidence first.
```

## Troubleshooting skills

| Skill | Use it for |
|---|---|
| [systematic-debugging](.claude/skills/systematic-debugging/SKILL.md) | Bugs, failing tests, integration errors, intermittent behavior, and performance regressions |
| [linux-troubleshooting](.claude/skills/linux-troubleshooting/SKILL.md) | Linux resource pressure, services, HTTP, SSH, networking, and deployments |
| [windows-troubleshooting](.claude/skills/windows-troubleshooting/SKILL.md) | Windows crashes, slowness, storage, services, drivers, updates, and connectivity |

Each skill includes scenario prompts under `evals/evals.json` for reviewing its
decisions. They are not an automatic test runner and do not authorize changes to
a real machine.

## Documentation

| Guide | Contents |
|---|---|
| [Agent Setup](docs/AGENT-SETUP.md) | A verified snapshot of one workstation's tools, plugins, memory, and workflow |
| [System Debug Kit](docs/SYSTEM-DEBUG-KIT.md) | Skill selection, scope, examples, repository layout, and validation limits |

## Repository layout

```text
playground/
├── .claude/skills/
│   ├── systematic-debugging/
│   ├── linux-troubleshooting/
│   └── windows-troubleshooting/
├── docs/
│   ├── AGENT-SETUP.md
│   └── SYSTEM-DEBUG-KIT.md
├── LICENSE
└── README.md
```

> [!CAUTION]
> Setup notes and diagnostic artifacts can contain personal data. Review and
> redact them before sharing, and keep credentials out of this repository.
