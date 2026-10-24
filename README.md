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
Read .agents/skills/windows-troubleshooting/SKILL.md and investigate this PC's
intermittent application crashes. Collect read-only evidence first.
```

## Troubleshooting skills

| Skill | Use it for |
|---|---|
| [systematic-debugging](.agents/skills/systematic-debugging/SKILL.md) | Bugs, failing tests, integration errors, intermittent behavior, and performance regressions |
| [linux-troubleshooting](.agents/skills/linux-troubleshooting/SKILL.md) | Linux resource pressure, services, HTTP, SSH, networking, and deployments |
| [windows-troubleshooting](.agents/skills/windows-troubleshooting/SKILL.md) | Windows crashes, slowness, storage, services, drivers, updates, and connectivity |

Each skill includes scenario prompts under `evals/evals.json` for reviewing its
decisions. They are not an automatic test runner and do not authorize changes to
a real machine.

## Portfolio and reverse-engineering skills

All seven project skills live canonically in `.agents/skills/`; `.claude/skills/`
holds local Windows junctions to them (not committed).

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
├── .agents/skills/          canonical project skills ×7 (Codex discovery)
├── .claude/skills/          seven junctions into .agents/skills (local only)
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
