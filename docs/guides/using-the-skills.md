<div align="center">

# Using the skills

*Pick the right project skill, brief the agent well, keep the limits in view*

[Repository](../../README.md) · [Skill layout](../architecture/skill-layout.md) · [Skill development](../workflows/skill-development.md)

</div>

This guide covers the human side: choosing a skill and briefing the agent.
The skill files themselves are instructions for agents and live in
`.agents/skills/`.

## Choose a skill

### Troubleshooting

| Skill | Use when | Key decisions |
|---|---|---|
| [systematic-debugging](../../.agents/skills/systematic-debugging/SKILL.md) | Bugs, failing tests, intermittent failures or unclear causes | Trace the failing boundary, test competing explanations, distinguish mitigation from root cause |
| [linux-troubleshooting](../../.agents/skills/linux-troubleshooting/SKILL.md) | Linux resource, service, HTTP, SSH, network, TLS or deployment failures | Identify host/container scope, collect bounded evidence, discover service names and respect authority |
| [windows-troubleshooting](../../.agents/skills/windows-troubleshooting/SKILL.md) | Windows crashes, slowness, services, drivers, updates, storage or connectivity | Identify target and shell, interpret counters/logs correctly and separate diagnosis from repair |

Use systematic debugging for the investigation method and an OS skill for
platform checks when both are relevant. Read only what the incident needs;
none requires a global plugin or another skill to function.

### Portfolio and reverse-engineering

| Skill | Use when |
|---|---|
| [jd-to-portfolio-tutor](../../.agents/skills/jd-to-portfolio-tutor/SKILL.md) | Learning a tool or stack from a job description by building a guided portfolio project |
| [job-description-analyzer](../../.agents/skills/job-description-analyzer/SKILL.md) | Scoring a job posting, finding skill gaps, planning the application |
| [portfolio-case-study-writer](../../.agents/skills/portfolio-case-study-writer/SKILL.md) | Turning resume bullets into detailed portfolio case studies |

These three skills are self-contained guides; they do not touch the incident
workflow above. The REA CLI for reverse engineering ships globally on this
workstation (`rea` on PATH), outside this repository.

## Brief the agent

Provide symptom and impact, exact target, onset/timezone, recent changes,
existing evidence and allowed interventions. Start with diagnosis when the
cause is unknown. Without target access, the useful output is a collection
plan and supported hypotheses, not invented results. Preserve error codes
while redacting secrets and personal data.

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

## Limits

> [!IMPORTANT]
> Syntax checks and simulated responses assess instructions. They do not prove
> a repair works, a remote host is healthy, or a diagnosis is correct. Incident
> closure needs target evidence and the original user-visible check.

Skills use the tools and authority available in the current session; they do
not install diagnostics or repair a machine on load. How each agent discovers
these skills is covered in [Skill layout](../architecture/skill-layout.md).
