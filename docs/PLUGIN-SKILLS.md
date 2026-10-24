# Plugin Skills Guide

What every installed plugin actually gives you, skill by skill — each description
restated in plain words instead of the original marketing sentence.

[Inventory](SKILLS-INVENTORY.md) · [Agent setup](AGENT-SETUP.md)

Snapshot: 2026-10-24, Claude-side versions. Codex runs the same plugins
(`superpowers` 7.0.0 and `pstack` 0.15.32 there are newer).

---

## superpowers — the disciplined process coach

Tells the agent *how to work*: brainstorm before building, plan before coding,
prove things work before claiming they do. You get this for free on most tasks;
the skill names are worth knowing because you can invoke them directly.

| Skill | In plain words |
|---|---|
| using-superpowers | The rulebook that loads first in every session: "check if a skill applies before you do anything" |
| brainstorming | Forces a requirements chat before any creative work — no jumping straight into code |
| writing-plans | Turns a rough spec into a step-by-step implementation plan |
| executing-plans | Runs an existing plan in a fresh session, pausing for your review at checkpoints |
| subagent-driven-development | Runs a plan by handing each task to a helper agent and checking the results |
| dispatching-parallel-agents | Splits independent tasks across several helper agents running at once |
| using-git-worktrees | Puts feature work in an isolated worktree so your main checkout stays clean |
| test-driven-development | Write the failing test first, then make it pass |
| systematic-debugging | Find the real cause before touching anything — no guess-fixing |
| verification-before-completion | Run the actual commands and read the output before saying "done" |
| requesting-code-review | Get the finished work reviewed against the requirements |
| receiving-code-review | Take review feedback seriously — verify claims instead of blindly agreeing |
| finishing-a-development-branch | Walks the merge / PR / cleanup decision once work is done |
| writing-skills | How to write a good skill file, with TDD for the skill itself |

## ponytail — the lazy senior developer

One philosophy: the smallest change that fully solves the task, explained in a
reply a busy human can read in one pass. Active by default in this workstation's
Claude sessions.

| Skill | In plain words |
|---|---|
| ponytail | The mode itself: cut scope, reuse what exists, no speculative features |
| ponytail-review | Review a change for bugs and over-engineering — "is every line needed?" |
| ponytail-audit | Same suspicion applied to a whole repo, ranked most-important-first |
| ponytail-debt | Collects every `shortcut:` comment into one debt ledger so deferrals get tracked |
| ponytail-gain | Scoreboard of what the mode saved (code, cost, speed) |
| ponytail-help | Quick reference card for the mode's levels and commands |

## caveman — terse replies plus a token-cost toolbox

Two halves. First, voice modes that squeeze the agent's replies down to save
output tokens. Second, a set of focused engineering workflows and a Cloud
service that measures where tokens actually go.

| Skill | In plain words |
|---|---|
| caveman | Terse "caveman voice" mode: answer first, fluff gone, facts kept |
| megacave | The same but written in Classical Chinese (文言文) — manual invocation only |
| ultracave | Maximum compression: sentence fragments, one word when one word is enough |
| caveman-help | Quick-reference card for the modes and commands |
| caveman-init | Drops an always-on activation rule into a repo so every agent speaks tersely |
| caveman-setup | Wires a repo through the Caveman Cloud gateway to measure every LLM request |
| caveman-discover | Finds and labels each LLM workflow in a repo so spending is grouped sensibly |
| caveman-stats | Shows what the current session spent in tokens and cache reads |
| caveman-evidence-review | Read-only look at the Cloud evidence: cost, score, traces, savings |
| caveman-learn | Acts on a learn report: applies the ranked token-saving fixes with your consent |
| caveman-optimize | Turns one optimization finding into a tested candidate, with explicit approval |
| caveman-manage | Inspects and safely blocks Cloud experiments (start, approve, roll back) |
| caveman-review | One line per finding code review |
| caveman-commit | Conventional Commit message compressed to intent only |
| caveman-compress | Shrinks a heavy memory file (e.g. CLAUDE.md) into caveman format |
| caveman-explore | Read-only repo scout for "where is this?" questions; returns file:line citations |
| investigate-first | Diagnose before editing when the cause is unknown or intermittent |
| lean-build | Build new features with strict scope and a stop condition, to avoid overbuilding |
| migration | Compatibility-safe transitions (schema, API, config) with rollback proof |
| safe-refactor | Restructure with verification before and after, so behavior provably stays put |
| surgical-patch | Fix a bug at the narrowest responsible layer, with regression proof |
| verify-and-stop | Prove the work meets acceptance conditions, then actually stop — no scope creep |
| cavecrew | Teaches the agent when to delegate to its three compressed-output helper agents |

## mattpocock-skills — planning, diagnosis and design vocabulary

A large toolbox from Matt Pocock's repo, strongest on: stress-testing a plan by
interviewing you, turning talk into specs and tickets, and a shared vocabulary
for designing code modules. Ships 38 skills; the session skill menu exposes a
subset — everything below exists on disk and can be invoked.

### engineering (20)

| Skill | In plain words |
|---|---|
| ask-matt | "Which skill fits my situation?" — a router over this whole set |
| code-review | Reviews changes on two axes: repo standards, and did it match the spec |
| codebase-design | Vocabulary for designing deep modules — where seams and interfaces go |
| diagnosing-bugs | Structured diagnosis loop for hard bugs and slow code |
| domain-modeling | Builds a glossary/ADR for your project's terms |
| grill-with-docs | Interview that sharpens a plan *and* writes ADRs and glossary as it goes |
| implement | Implement a piece of work from a spec or tickets |
| implement-spec | Implement specifically the output of to-spec / to-tickets |
| improve-codebase-architecture | Scans for structural improvements, shows an HTML report, discusses your pick |
| pr | Writes the PR body |
| prototype | Build a throwaway prototype to answer one design question |
| research | Investigates a question against primary sources, saves findings as Markdown |
| retro | Retrospective on a coding session — what to keep doing, what to stop |
| setup-matt-pocock-skills | One-time config: issue tracker, triage labels, doc layout |
| tdd | Test-first development: red, green, refactor |
| to-spec | Turns the current conversation into a published spec, no extra questions |
| to-tickets | Breaks a plan into small tickets with explicit blocking edges |
| triage | Moves issues and PRs through a triage state machine into agent-ready briefs |
| wayfinder | Plans work too big for one session as decision tickets, resolved one at a time |
| wizard | Generates an interactive bash wizard for steps only a human can do (secrets, dashboards) |

### productivity (7)

| Skill | In plain words |
|---|---|
| grilling | Relentless interview to stress-test your plan or decision |
| grill-me | Same idea, alternate phrasing |
| handoff | Compresses the conversation into a handoff doc for another agent |
| teach | Teaches you a concept inside this workspace |
| to-questionnaire | Turns an unanswerable decision into a questionnaire for someone else |
| wait-what | "Stop — that explanation didn't land, try again" |
| writing-for-agents | How to write documents (skills, AGENTS.md, CLAUDE.md) that agents follow |

### misc (4)

| Skill | In plain words |
|---|---|
| git-guardrails-claude-code | Installs hooks that block dangerous git commands (push, reset --hard…) |
| setup-pre-commit | Sets up Husky + Prettier + typecheck + tests as pre-commit hooks |
| migrate-to-shoehorn | Migrates `as` type assertions in tests to the shoehorn library |
| scaffold-exercises | Creates course-exercise folders (problems, solutions, explainers) |

### in-progress (7) — author's drafts, expect rough edges

chief-of-staff (one session chasing a long goal via subagents), claude-handoff
(park the work with a background agent), loop-me (grill about workflow specs),
setup-ts-deep-modules (wire dependency-cruiser for deep modules), writing-beats
/ writing-fragments / writing-shape (a three-stage writing method).

## pstack — 56 skills: principles, parallelism and proof

The biggest bundle. Its centre of gravity: **24 named "principles"** (one-lesson
skills the agent applies at the right moment), **parallel worker patterns**
(swarm, arena), **verification generators**, and **communication helpers**.
Like mattpocock-skills, the session menu exposes a subset until configured.

### Principles (24) — one lesson each

| Skill | The lesson in plain words |
|---|---|
| principle-foundational-thinking | Get the data structures right first; the code around them becomes obvious |
| principle-type-system-discipline | Make illegal states unrepresentable; parse external data at the boundary |
| principle-model-the-domain | Shape code around the real domain, especially when it branches a lot |
| principle-boundary-discipline | Guard at system edges (CLI, network, config); keep business logic pure |
| principle-fix-root-causes | Trace the symptom to where it went wrong first; fix it there |
| principle-prove-it-works | Verify against the real artifact before calling it done |
| principle-explain-the-number | Before trusting a measurement, learn what limits it and what it really measured |
| principle-benchmark-checklist | (paired skill) Vet a perf measurement before reporting it |
| principle-laziness-protocol | Prefer deletion; smallest change that solves it |
| principle-subtract-before-you-add | Remove dead code and stubs before building on top |
| principle-build-the-lever | Write the tool/codemod that does the work instead of doing it by hand |
| principle-encode-lessons-in-structure | Same instruction twice? Make it a lint or check, not more prose |
| principle-test-behavior-not-implementation | Assert what users can observe, not internal wiring |
| principle-minimize-reader-load | Fewer layers, less hidden state for the next reader |
| principle-guard-the-context-window | Route bulk reads to subagents; keep summaries in the main thread |
| principle-separate-before-serializing-shared-state | Kill shared state before adding locks around it |
| principle-make-operations-idempotent | Commands should converge to the same end state after crashes and retries |
| principle-sequence-verifiable-units | Split work so each unit ends verifiable, and order them so the sequence proves itself |
| principle-never-block-on-the-human | Don't ask permission for reversible work — do it, report it |
| principle-outcome-oriented-execution | During a rewrite, converge on the target; don't polish intermediate states |
| principle-migrate-callers-then-delete-legacy-apis | New API in, old API deleted — same wave, no compatibility shims |
| principle-attack-the-premise | When two fixes sharing one assumption failed, test the assumption itself |
| principle-exhaust-the-design-space | For novel decisions, build 2–3 prototypes and compare, don't commit blind |
| principle-experience-first | When tradeoffs come up, pick user delight over implementation convenience |
| principle-redesign-from-first-principles | Integrate new requirements by rethinking, not bolting on |

### Skills (32)

| Skill | In plain words |
|---|---|
| setup-pstack | One-time config: which model plays which role, at what reasoning budget |
| poteto-help | Guide to pstack itself: setup, /poteto-mode, picking a skill |
| poteto-mode | poteto's agent style: concise, subagent-heavy, unslopped prose, verified work |
| architect | Sketch types and module shapes before coding |
| arena | Run N candidate attempts in parallel, keep the best, graft in the rest |
| swarm | Fan out N parallel workers, drain them, one report back |
| reflect | Three review subagents over the session transcript; each learning becomes a skill edit |
| interrogate | Adversarial multi-angle review: "stress test this", "find blind spots" |
| blast-radius | What could this change break elsewhere? Prove the one fact it's safe because of |
| benchmark-checklist | Vet a performance measurement before you believe or repeat it |
| correct | Find the mistakes the agent keeps repeating here and make each one impossible |
| how | "How does X work?" — architecture walkthrough, ownership and layering answers |
| why | "Why is it this way?" — digs through git, issues, docs and chat for the rationale |
| teach | Explains a body of work plainly, weaving `how` + `why` together |
| recall | Rebuild "what was I working on?" from history and live state into a short brief |
| ketchup | Catch-up since your last message: what changed, what's waiting on you |
| bro | Restate the last message in plain human language, no jargon |
| in-your-own-words | Agent restates your goal in its own words to confirm understanding |
| sharpen | Make a task deeper, not bigger, then rewrite the prompt |
| figure-it-out | Auditable playbook for big migrations or work you'll review after stepping away |
| show-me-your-work | Keeps a decision log (what, why, evidence) for long-running work |
| tdd | Only for explicit test-first requests or cheap obvious regression tests |
| create-verification-skill | Generates a project-local skill that drives your app like a user would |
| maintain-verification-skill | Periodic pass keeping that verification skill honest as code changes |
| create-formal-verification-skill | Generates formal (model-checking) verification where bugs cost most |
| maintain-formal-verification-skill | Realigns the formal model after code changes |
| technical-writing | Docs standard: Diátaxis structure, Google style, Global English |
| unslop | Removes AI-sounding tells from writing |
| no-comments | Deletes comment noise via the Comment Sicko agent; encodes constraints in code |
| typescript-best-practices | TS/TSX conventions, applied when reading or editing those files |
| automate-me | Captures your working style into a personal "-mode" skill |
| make-bot-ui | Builds a custom UI that wakes a Grok bot over a webhook (manual invocation) |

## claude-mem — persistent memory and its automation on top

Remembers past sessions and then automates the plan → build → verify → release
loop around them. The memory core runs invisibly via hooks; these are the
skills you'd invoke.

| Skill | In plain words |
|---|---|
| mem-search | Search everything remembered from past sessions |
| how-it-works | Explains what claude-mem is capturing and where it lives |
| learn-codebase | Reads the whole repo up front so memory starts primed (~5 min) |
| smart-explore | Token-cheap code structure search (AST-based, no full-file reads) |
| knowledge-agent | Builds a queryable "brain" from accumulated observations |
| mode-creator | Customizes what claude-mem records (observation types, tags, alerts) |
| cloud-sync | Backs the memory database up to cmem.ai |
| screenpipe | Searches desktop screen/audio history and saves snippets into memory |
| make-plan | Detailed phased implementation plan from a feature idea |
| do | Executes a plan with subagents, phase by phase |
| build | Full pipeline: make-plan → do → babysit |
| babysit | Watches a PR — comments, reviews, CI — until it's mergeable |
| childhood | Keeps watching a release *after* it ships until the observation window is clean |
| handoff | Writes HANDOFF.md so a fresh session continues exactly here |
| release | Automated release: version bump through publication |
| version-bump | Semver bump across manifests, tags, GitHub release, changelog |
| build-and-release | Build plus release in one run |
| agent-cost-report | Cost report for any period from real transcripts (estimated prices) |
| timeline-report | Narrative report of a project's whole development history |
| weekly-digests | Week-by-week serial story of the project's memory timeline |
| standup | Read-only standup across worktrees/branches/PRs, one consolidation plan |
| pathfinder | Flowchart map of a codebase; spots duplicated systems, proposes one architecture |
| oh-my-issues | Clusters a big issue backlog by root cause into plan-master issues |
| design-is | Design audit against Dieter Rams' ten principles, ends in a plan |
| what-the | "What the?" — plain-English who/what/where/why/when breakdown of anything technical |
| wowerpoint | Turns one document into a kawaii slide deck |
| ccs-align | Hourly health-and-alignment cycle for the local claude-mem worker (ops) |

## andrej-karpathy-skills — one skill

| Skill | In plain words |
|---|---|
| karpathy-guidelines | Don't overcomplicate; change surgically; state assumptions; define what "works" means before claiming it |

---

> [!NOTE]
> **Deliberate overlaps exist.** `tdd`, `code-review`/`ponytail-review`,
> `handoff`, `teach` and the grill family appear in more than one plugin.
> Each agent loads every description into context, so every duplicate costs
> tokens — see the [setup notes](AGENT-SETUP.md#toolbox).

> [!TIP]
> Skills that say "use when…" trigger automatically; the rest are
> slash-command style and you invoke them by name.
