<div align="center">

# Skill layout

*One canonical source, one compatibility layer*

[Repository](../../README.md) · [Agent setup](../setup/agent-setup.md)

</div>

## The decision

The repository keeps exactly one physical copy of each project skill, in
`.agents/skills/`. `.claude/skills/` holds NTFS junctions,
one per skill, pointing at the canonical directories. The junctions are
gitignored and recreated per machine. A second physical copy was rejected:
two editable copies drift, and the drift reaches agent behavior through
discovery.

## How each agent finds the skills

**Claude Code** discovers project skills in [`.claude/skills/`](https://code.claude.com/docs/en/skills#where-skills-live);
the junctions
make that path resolve to the canonical files. Open a session in this project
and select an available skill, or ask the agent to read its file explicitly.
Restart the session if a changed skill is not reflected in the available list.

**Codex** reads `.agents/skills/` natively and needs no link. Verify a skill
appears in the selector, and avoid duplicate names.

Discovery makes instructions available; it does not execute every check
automatically.

## Authority boundaries

- `.agents/skills/<skill>/SKILL.md` is authoritative for agent behavior.
- Documentation serves humans; when the two disagree, the skill file wins and
  the docs get fixed.
- User-scope installs (`~/.agents/skills/`, plugins) live outside this
  repository; see [Agent setup](../setup/agent-setup.md) and
  [Skills inventory](../reference/skills-inventory.md).

## Layout

```text
.agents/skills/                     canonical copies, committed (Codex discovery path)
├── systematic-debugging/           SKILL.md + evals/evals.json
├── linux-troubleshooting/          SKILL.md + evals/evals.json
├── windows-troubleshooting/        SKILL.md + evals/evals.json
├── jd-to-portfolio-tutor/          SKILL.md + agents/
├── job-description-analyzer/       SKILL.md
└── portfolio-case-study-writer/    SKILL.md

.claude/skills/                     six junctions into .agents/skills (gitignored)
```

`SKILL.md` holds operational instructions. Eval files hold prompts and expected
decisions for review; usage limits are covered in
[Using the skills](../guides/using-the-skills.md#limits). Editing a skill:
[Skill development](../workflows/skill-development.md).

## Operating rules

Rules for changing this layout.

1. **Create before delete.** Add each replacement link and verify it resolves
   before removing the original directory. In a batch, one failed command must
   abort the run; a guard that runs afterwards does not stop anything.
2. **Pilot one element first.** Run the link command on a single skill and
   inspect the created path before looping. A broken command repeats once per
   element.
3. **Never `rm -rf` through a junction.** The link resolves into
   `.agents/skills/`, so a recursive delete through it can erase the canonical
   store. Remove a junction with `cmd //c rmdir <junction>`.
4. **Plugin skills sit seven levels deep.** They live at
   `~/.claude/plugins/cache/<marketplace>/<plugin>/<version>/skills/<name>/`;
   search with `-maxdepth 8` or the glob `cache/*/*/*/skills`, or a shallow
   `find` silently misses them.
5. **Check every harness before pruning.** Claude and Codex reach
   plugin-covered skills through their plugins; harnesses without a plugin
   system, such as QwenWork, read `~/.agents/skills/` directly and lose deleted
   entries. Confirm each consumer before removing anything from the store.
