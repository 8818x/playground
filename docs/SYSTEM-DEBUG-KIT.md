<div align="center">

# System Debug Kit

*Evidence first, one justified change, then verify the original symptom*

[Repository](../README.md) · [Agent setup](AGENT-SETUP.md)

</div>

This project carries three self-contained troubleshooting skills. Each is
written for this repository and includes scenario prompts for checking the
agent's decisions. They use the tools and authority available in the current
session; they do not install diagnostics or repair a machine on load.

## Choose a skill

| Skill | Use when | Key decisions |
|---|---|---|
| [systematic-debugging](../.agents/skills/systematic-debugging/SKILL.md) | Bugs, failing tests, intermittent failures or unclear causes | Trace the failing boundary, test competing explanations, distinguish mitigation from root cause |
| [linux-troubleshooting](../.agents/skills/linux-troubleshooting/SKILL.md) | Linux resource, service, HTTP, SSH, network, TLS or deployment failures | Identify host/container scope, collect bounded evidence, discover service names and respect authority |
| [windows-troubleshooting](../.agents/skills/windows-troubleshooting/SKILL.md) | Windows crashes, slowness, services, drivers, updates, storage or connectivity | Identify target and shell, interpret counters/logs correctly and separate diagnosis from repair |

Use systematic debugging for the investigation method and an OS skill for
platform checks when both are relevant. Read only what the incident needs;
none requires a global plugin or another skill to function.

## Using the skills

**Claude Code:** the [project skill directory](https://code.claude.com/docs/en/skills#where-skills-live)
is `.claude/skills/`, which here holds local Windows junctions into the
canonical `.agents/skills/`. Open a session in this project and select an
available skill, or ask the agent to read its file explicitly. Restart the
session if a changed skill is not reflected in the available list. Discovery
makes instructions available; it does not execute every check automatically.

**Codex:** the [official discovery locations](https://learn.chatgpt.com/docs/build-skills#where-codex-loads-local-skills)
include repository `.agents/skills/`, which this project ships as the canonical
location. Verify a skill appears in the selector and avoid duplicate names;
compatible files alone do not establish automatic discovery by both agents.

Example requests:

```text
Read .agents/skills/systematic-debugging/SKILL.md. This test fails only in CI;
trace the first boundary where the inputs differ. Do not print secrets.
```

```text
Read .agents/skills/linux-troubleshooting/SKILL.md. The API returns 502 after
deployment. We have diagnosis-only SSH access; identify the next useful check.
```

```text
Read .agents/skills/windows-troubleshooting/SKILL.md. This Windows laptop
freezes intermittently. Collect a bounded baseline and event evidence first.
```

Provide symptom and impact, exact target, onset/timezone, recent changes,
existing evidence and allowed interventions. Without target access, the useful
output is a collection plan and supported hypotheses, not invented results.
Preserve error codes while redacting secrets and personal data.

## Layout

```text
.agents/skills/            canonical copies, committed (Codex discovery path)
├── systematic-debugging/
│   ├── SKILL.md
│   └── evals/evals.json
├── linux-troubleshooting/
│   ├── SKILL.md
│   └── evals/evals.json
└── windows-troubleshooting/
    ├── SKILL.md
    └── evals/evals.json
```

`.claude/skills/` holds local Windows junctions to these directories; they are
gitignored and recreated per machine.

`SKILL.md` holds operational instructions. Eval files hold prompts and expected
decisions for review; they are not an automatic runner and do not authorize
changes to a real host.

## Improving a skill

1. Start from a real failure or a specific decision the current instructions
   handle poorly. Keep existing names so callers continue to find the skill.
2. Write clear frontmatter triggers and concise, self-contained steps. Include
   tool/access limits and a completion check. Supply every referenced local file.
3. Add realistic scenario prompts and expected behaviors under `evals/`.
   Compare old and new responses when evaluating a behavior change.
4. Validate frontmatter, JSON, local links and command syntax. Run safe examples
   on the intended platform when available; report checks not run.
5. Review the diff and repeat the original scenario before claiming improvement.

The user-installed `skill-creator` helps with this process; see
[Agent Setup](AGENT-SETUP.md#standalone-skills). Follow the
[Agent Skills specification](https://agentskills.io/specification) for packaging.

> [!IMPORTANT]
> Syntax checks and simulated responses assess instructions. They do not prove
> a repair works, a remote host is healthy, or a diagnosis is correct. Incident
> closure needs target evidence and the original user-visible check.
