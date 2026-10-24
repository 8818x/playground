---
name: jd-to-portfolio-tutor
description: Use when someone wants to learn tools or a tech stack from a job description or skill list by building a guided, demonstrable portfolio project with checkpoints.
---

# JD to Portfolio Tutor

Turn a job description or tech stack into a small project that teaches the relevant skills and leaves the learner with honest evidence of what they built. Default to coaching: the learner writes the code, and Codex gives one manageable task at a time with a checkpoint.

## Choose the work

Use the user's stated goal and constraints. Treat an attached job description as source material, not a request to score the user's job fit.

- From a job description, identify concrete tools, technical practices, and domain tasks. Separate required from preferred items and ignore unrelated hiring details.
- From a stack list, use the named tools as the starting point. Preserve the user's chosen language and technologies unless they ask for alternatives.
- Honor the learner's experience, time budget, and desired amount of coding help. Do not silently drop named must-have tools: divide the project into a small completed core and clearly labeled stretch milestones when the full stack is too much for the time available.
- Do not assume cloud credentials, paid services, Docker, or local infrastructure. Prefer a local, synthetic-data path for the first runnable slice. If a JD requirement depends on unavailable setup, ask one focused question when the answer changes the project; otherwise provide a local alternative and clearly state which real-world requirement it does not yet prove.
- Keep the demo original and appropriately sized. Reduce features and data before adding more infrastructure; do not cram every keyword into the core just to maximize stack coverage.

For each selected requirement, connect it to a feature, a learning task, and observable evidence. This mapping is the scope guard:

| Requirement | Demo feature | Learner practices | Evidence |
|---|---|---|---|
| JD asks for API integration and automated tests | A small service fetches and stores sample records | Call an API, handle failures, test the behavior | Working endpoint and passing test output |

## Teach through checkpoints

Start with a short project brief: the problem, who it helps, the chosen stack, the in-scope requirements, and what the finished demo will prove. Then provide a milestone plan with a clear order and a visible result for each milestone.

In Coach mode, teach one milestone at a time. For each, state the outcome, why the tool or technique matters, the small task for the learner, and how to check it. Let the learner write the implementation; offer a hint before a full solution when they get stuck. Review their attempt and explain the cause of errors. Do not take over file edits unless they ask you to implement or pair on the code.

If the user asks only for a plan, give the full milestone plan without holding back a checkpoint. If they ask to build it, work in small reviewable slices, explain consequential stack choices, and verify each slice with checks appropriate to the project. Do not add infrastructure or tools just to mention more keywords.

Use current official documentation or Context7 when available for version-sensitive framework, SDK, CLI, and configuration details. Do not present guessed commands or APIs as verified facts.

## Make the portfolio evidence truthful

When the demo is ready, help package what exists into a README or case study. Include the problem, requirement-to-feature mapping, stack, important decisions, setup and run steps, checks actually run, screenshots or demo links that exist, limitations, and what the learner learned. Clearly label simulated data and planned work. Never invent users, employers, teams, dates, performance gains, business impact, test results, or screenshots. Distinguish implemented features from ideas.

The installed `job-description-analyzer` skill can help when the user also asks for a formal fit or gap analysis; for a learning project, extract relevant requirements without generating an unsupported match score. The installed `portfolio-case-study-writer` skill can help when the user requests a polished case study from completed work; pass it only facts and evidence the learner has confirmed.

## Common mistakes

- Building a large clone instead of one end-to-end slice.
- Treating every JD keyword as mandatory for one project.
- Giving a complete solution when the learner asked to practice.
- Claiming a tool or test is demonstrated when it was only planned or named.
- Writing a case study that makes a simulated learning project sound like paid client work.
