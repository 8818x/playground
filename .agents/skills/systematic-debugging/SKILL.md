---
name: systematic-debugging
description: Diagnose bugs, failing tests, build or integration errors, intermittent failures, and performance regressions before choosing a fix. Use especially when a cause is unknown or earlier fixes have failed.
license: MIT
metadata:
  author: 8818x
  scope: project
  origin: Original skill written for this repository
---

# Systematic debugging

Build a causal explanation from evidence, then change the smallest responsible
part. Scale the investigation to the failure: a clear local reproduction can be
enough; a distributed or intermittent failure needs evidence across boundaries.
This workflow is self-contained and requires no companion skills.

## 1. Establish the failure

- Record expected versus actual behavior, the exact failing command or request,
  relevant error and stack trace, environment, and recent changes. Inspect only
  the configuration and history that could affect this path.
- Try the smallest safe reproduction. Preserve the failing input, relevant
  versions, and conditions so the same check can verify the eventual fix.
- For intermittent failures, record attempts and failures, timestamps, correlation
  IDs, load, and other distinguishing conditions. A clean run does not disprove
  an intermittent bug.
- If access or reproduction is unavailable, identify what is missing, collect
  available evidence, and give the smallest next diagnostic step. State what
  remains unknown; missing evidence does not establish an external cause.

Proceed when you have a reproducible failure or an explicit evidence gap with
a concrete way to narrow it.

## 2. Locate the first wrong transition

Follow the failing value or state backward from the symptom to its origin.
At each relevant boundary (workflow to script, process to service, service to
database), compare what the producer sends with what the consumer receives.
Check configuration presence, types, shape, permissions, timing, and outcomes
only as needed to distinguish causes. Compare with a working path and explain
which differences could account for the failure.

Use the project's graph tools for code discovery when available; use text
search for literals and configuration or when graph results are insufficient.
For version-sensitive library behavior, consult the project's documentation
tools and pin the installed version rather than guessing from memory.

Collect diagnostics without disclosing secrets. Log allowlisted presence flags,
status codes, redacted identifiers, and counts. Keep credentials, tokens, private
keys, sensitive payloads, and full environment dumps out of logs and reports.
For example, this Bash check reports only whether a value is nonempty:

```bash
if [ -n "${SIGNING_IDENTITY:-}" ]; then
  printf '%s\n' 'SIGNING_IDENTITY=present'
else
  printf '%s\n' 'SIGNING_IDENTITY=missing-or-empty'
fi
```

Run such checks with shell tracing disabled; tracing can expose expanded values.
Use the native equivalent in the active shell. Inspect and redact any tool
output before sharing it. Remove temporary diagnostics once no longer needed.

Proceed when evidence identifies a suspect transition or narrows the next test
to a specific boundary; avoid instrumenting unrelated components.

## 3. Test one explanation

Write: "I suspect X because Y. If true, test Z should produce W."
Choose the cheapest safe test that distinguishes this explanation from its
alternatives. Change one variable and compare the predicted with observed
result. Keep a short record of hypothesis, test, result, and implication.

A rejected hypothesis is new evidence. Revert only your failed experimental
changes, preserving unrelated user work, before testing another explanation.
After repeated failures, summarize what was ruled out, check your assumptions
and the quality of the reproduction, and choose a new discriminating test.
Consider architecture only when evidence points to coupling or violated
invariants; a count of failed attempts alone proves no architectural defect.

Proceed to a lasting fix when the causal mechanism explains the observed
failure and a targeted check supports it. Otherwise continue diagnosis or
report the precise access or evidence limitation.

## 4. Fix and verify

Capture a failing regression check before changing behavior when feasible.
Prefer an existing focused test; otherwise use a small reproduction or a
documented manual check. Explain any limitation instead of inventing proof.
Apply the minimal fix at the responsible layer, without unrelated cleanup.

Rerun the original check and relevant neighboring checks. For intermittent or
performance failures, compare equivalent conditions over enough attempts to
state the observed result and its limits. If the fix fails, return to diagnosis
with the new evidence rather than stacking speculative changes.

Finish with the supported cause (or remaining hypothesis), what changed, exact
checks and outcomes, and any unresolved limitation. Claim resolution only to
the extent those checks establish it.

## Urgent mitigation

When service restoration is urgent, carry out an already authorized, bounded,
reversible mitigation such as rollback or disabling the affected feature.
Preserve useful evidence when feasible, record the risk and rollback path,
and verify that the mitigation restores the affected behavior. Label it as
mitigation and continue root-cause investigation; restored service alone does
not confirm the cause. Reuse existing authorization and ask only if the needed
action exceeds it.

## Evaluation cases

[evals/evals.json](evals/evals.json) contains three scenarios for checking safe
pipeline diagnostics, intermittent failures with limited access, and repeated
failed fixes. These are evaluation inputs, not evidence of completed test runs.
