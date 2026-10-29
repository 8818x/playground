<div align="center">

# Skill development

*How to change a project skill without degrading it*

[Repository](../../README.md) · [Using the skills](../guides/using-the-skills.md)

</div>

All edits go to `.agents/skills/<skill-name>/`, the canonical source. The
`.claude/skills/` entries are compatibility junctions, never separate editable
copies. Restart a session after editing so discovery reflects the change.

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
[Agent setup](../setup/agent-setup.md#standalone-skills). Follow the
[Agent Skills specification](https://agentskills.io/specification) for packaging.
