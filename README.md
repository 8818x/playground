<div align="center">

<img src="assets/toolkittens-logo.png" alt="Toolkit(ten)s" width="220" />

# Toolkit(ten)s

*A practical field kit for Claude Code and Codex on Windows*

[Get started](#get-started) · [Debug kit](#debug-kit) · [Documentation](#documentation)

</div>

Toolkit(ten)s keeps troubleshooting skills and notes about one working agent
setup in a small repository. Use the skills to investigate software bugs and
Linux or Windows incidents; use the guides to understand the surrounding
plugins, MCP tools and memory workflow.

> [!NOTE]
> This is a field kit and a machine-specific setup record, not an installer.
> Cloning it does not install plugins, configure credentials or start services.
> Documentation reviewed **2026-10-21**.

## Get started

1. Open this repository in your terminal or editor.
2. Read [System Debug Kit](docs/SYSTEM-DEBUG-KIT.md) and choose the skill matching
   the incident. Each skill is self-contained.
3. Give the agent the symptom, affected target, evidence and allowed actions.
   Start with diagnosis when the cause is unknown.

For example:

```text
Read .claude/skills/windows-troubleshooting/SKILL.md and use it to investigate
this PC's intermittent application crashes. Collect read-only evidence first.
```

Claude Code discovers the project skills in `.claude/skills/`. For Codex,
explicitly ask it to read the relevant file; this checkout does not include a
project `.agents/skills/` discovery directory. See the
[scope notes](docs/SYSTEM-DEBUG-KIT.md#using-the-skills) before installing copies
elsewhere.

## Debug kit

| Skill | Use it for |
|---|---|
| [systematic-debugging](.claude/skills/systematic-debugging/SKILL.md) | Bugs, failing tests, intermittent behavior and failures across component boundaries |
| [linux-troubleshooting](.claude/skills/linux-troubleshooting/SKILL.md) | Linux resource pressure, failed services, HTTP errors, SSH, networking and deployments |
| [windows-troubleshooting](.claude/skills/windows-troubleshooting/SKILL.md) | Windows crashes, slowness, storage, services, drivers, updates and connectivity |

All three are written for this project. Their common workflow is to preserve
evidence, test a specific hypothesis, make one justified change within existing
authority, and repeat the original failing check. Each includes scenario prompts
under `evals/evals.json` for reviewing its behavior.

## Documentation

| Guide | Contents |
|---|---|
| [Agent Setup](docs/AGENT-SETUP.md) | Verified CLI/plugin snapshot, standalone skills, MCP roles, memory, workflow and Windows caveats |
| [System Debug Kit](docs/SYSTEM-DEBUG-KIT.md) | Skill selection, scope, examples, layout and validation limits |

```text
toolkittens/
├── README.md
├── docs/
│   ├── AGENT-SETUP.md
│   └── SYSTEM-DEBUG-KIT.md
├── .claude/skills/
│   ├── systematic-debugging/
│   ├── linux-troubleshooting/
│   └── windows-troubleshooting/
└── assets/toolkittens-logo.png
```

## Working habits

- Use the code graph for symbols and callers, Context7 for version-sensitive
  APIs, and primary sources for external facts.
- Use `skill-creator` for skill authoring and `create-readme` for project docs.
  These are user-installed tools described in the setup guide.
- Keep recall and improvement separate: `claude-mem` provides session memory;
  `task-observer` records opportunities to improve skills.
- Review and verify the exact changes before committing. A simulated skill
  response does not establish that an incident was fixed on a real machine.

> [!CAUTION]
> Agent configs, diagnostic logs and memory stores can contain secrets or
> personal data. Review and redact them before sharing; keep credentials out
> of this repository.
