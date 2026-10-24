# Playground

*Troubleshooting skills and setup notes for Claude Code and Codex on Windows.*

[Get started](#get-started) | [Troubleshooting skills](#troubleshooting-skills) | [Documentation](#documentation)

Playground collects three project-local troubleshooting skills, a portfolio and
reverse-engineering skill suite, and notes about one working agent setup. Use
the skills to investigate software bugs and Linux or Windows incidents, and the
guides to understand the surrounding tools and workflow.

> [!NOTE]
> This repository records a machine-specific setup; it is not an installer.
> Cloning it does not install plugins, configure credentials, or start services.

## Get started

1. Open this repository in your terminal or editor.
2. Read the [System Debug Kit](docs/SYSTEM-DEBUG-KIT.md) and choose a skill for
   the incident.
3. Give the agent the symptom, affected target, evidence, and allowed actions.
   Start with diagnosis when the cause is unknown.

Claude Code discovers project skills in `.claude/skills/`; Codex discovers
`.agents/skills/`. Both directories are checked in, so both agents read the
same skill files in this checkout.

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

## Portfolio and reverse-engineering skills

The `.agents/skills/` directory holds the canonical copies; `.claude/skills/`
links to them with local Windows junctions (not committed).

| Skill | Use it for |
|---|---|
| [jd-to-portfolio-tutor](.agents/skills/jd-to-portfolio-tutor/SKILL.md) | Learning a tool or stack from a job description by building a guided portfolio project |
| [job-description-analyzer](.agents/skills/job-description-analyzer/SKILL.md) | Scoring a job posting, finding skill gaps, planning the application |
| [portfolio-case-study-writer](.agents/skills/portfolio-case-study-writer/SKILL.md) | Turning resume bullets into detailed case studies |
| [reverse-engineer-anything](.agents/skills/reverse-engineer-anything/SKILL.md) | Decompiling and explaining shipped software without source |

## Documentation

| Guide | Contents |
|---|---|
| [Agent Setup](docs/AGENT-SETUP.md) | A verified snapshot of one workstation's tools, plugins, memory, and workflow |
| [System Debug Kit](docs/SYSTEM-DEBUG-KIT.md) | Skill selection, scope, examples, repository layout, and validation limits |
| [Skills Inventory](docs/SKILLS-INVENTORY.md) | Every installed user-scope skill for Claude and Codex, split by source |
| [Plugin Skills Guide](docs/PLUGIN-SKILLS.md) | Plain-language description of every skill inside the seven installed plugins |

## Repository layout

```text
playground/
├── .agents/skills/          canonical portfolio/RE skill suite (Codex discovery)
├── .claude/skills/
│   ├── systematic-debugging/  + linux- and windows-troubleshooting
│   └── jd-to-portfolio-tutor  + three junctions into .agents/skills
├── docs/
│   ├── AGENT-SETUP.md
│   ├── SYSTEM-DEBUG-KIT.md
│   ├── SKILLS-INVENTORY.md
│   └── PLUGIN-SKILLS.md
├── LICENSE
└── README.md
```

> [!CAUTION]
> Setup notes and diagnostic artifacts can contain personal data. Review and
> redact them before sharing, and keep credentials out of this repository.
