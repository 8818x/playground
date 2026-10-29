---
name: linux-troubleshooting
description: Use when a Linux host or workload is slow, out of memory, out of disk space, failing to start, returning HTTP errors, unreachable over SSH, or experiencing DNS, network, TLS, or deployment failures, including incidents where server access is unavailable.
license: MIT
compatibility: Linux target; shell or operator-provided evidence. Commands depend on installed tools, privileges, init system, and namespace.
metadata:
  author: 8818x
  scope: project
  origin: Original skill written for this repository
---

# Linux Troubleshooting

Find the failing layer, collect evidence that separates likely causes, then
make the smallest authorized correction. This skill is self-contained; it
requires no companion skill, installer, or bundled command wrapper.

## 1. Locate the incident

Establish the affected host/service, user-visible failure, onset and timezone,
scope of impact, recent changes, and existing authority to intervene. Reuse
answers already supplied. Ask only for missing details that change the next step.

Identify the execution location before running commands: operator laptop,
remote Linux host, container, or host namespace. A check in one location does
not establish the state of another. On Windows, use an authorized Linux shell
or give the operator collection commands; do not run Linux commands locally
and report their output as server evidence.

Without target access, report a collection plan and hypotheses. Never invent
command output or claim the host is healthy. With partial privileges, mark
inaccessible logs/processes as unassessed rather than absent.

## 2. Preserve a small baseline

Collect the original failing check, timestamps, relevant state and logs before
intervention. Use separate commands so one failure does not hide later checks.
For a broad host incident, start with:

```bash
date -Is
cat /etc/os-release
uname -r
ps -p 1 -o comm=
uptime
free -h
df -h
df -i
```

These commands are Linux examples, not a universal dependency guarantee.
Discover available tools with `command -v`. Confirm the init system before
using `systemctl`; in containers or other init systems, inspect the actual
supervisor/runtime. Identify real service names, paths, mounts and endpoints;
do not assume Apache, Nginx, a PHP version, or a particular firewall exists.

For a known systemd service, substitute its discovered unit into this template:

```bash
unit='REPLACE_WITH_DISCOVERED.service'
systemctl status "$unit" --no-pager --full
systemctl show "$unit" -p ActiveState -p SubState -p Result -p ExecMainStatus
journalctl -u "$unit" --since '30 minutes ago' -n 100 --no-pager
```

Choose a time window around the actual onset, including date and timezone for
older incidents. A nonzero status may describe the failure being investigated.
Use authorized elevation only when necessary. Keep raw secrets out of chat:
redact credentials, tokens, connection strings and identifying customer data
from logs, configs and SSH diagnostics. Retain timestamps and error codes.

## 3. Follow the symptom

Start with the smallest relevant row. Record one hypothesis, its discriminating
check and the result before changing direction. Correlation with a deployment
is a lead, not proof. Missing tools or denied access leave a gap, not a negative finding.

| Symptom | First checks | Interpretation and next step |
|---|---|---|
| High load / slow host | Compare CPU count (`getconf _NPROCESSORS_ONLN`), `uptime`, `vmstat 1 5`, and `ps -eo pid,ppid,stat,pcpu,pmem,comm --sort=-pcpu`. | Load includes runnable and uninterruptible tasks; distinguish CPU contention, blocked I/O, and memory pressure. Ignore the first `vmstat` report when assessing interval activity. Use optional `iostat` only if available. |
| Memory / OOM | Inspect available memory and swap with `free -h`; compare process RSS using `ps -eo pid,ppid,rss,comm --sort=-rss`. Check kernel logs around onset. | Low free memory alone is not OOM. Seek kill evidence and the affected PID. In a container, inspect its memory limit/events and host evidence separately; host free memory does not prove container headroom. |
| Disk full / ENOSPC | Identify the failing path's mount with `df -h /affected/path` and `df -i /affected/path`. If installed, use `lsof +L1` to inspect deleted-open files. | Separate block exhaustion, inode exhaustion, quotas, and read-only mounts. Match open file owner and filesystem. Inspect a bounded directory on that mount with `du -x -h --max-depth=1 /affected/directory`; expand only as needed because scans add I/O. |
| Service won't start | Read unit/supervisor state, exit reason, relevant logs, listener and dependencies; validate config using the application's documented check. | Discover the actual unit and runtime first. Distinguish syntax, missing dependency, wrong path, port conflict, permissions and resource limits before choosing a fix. |
| HTTP 5xx / 502 / 504 | Reproduce the original request; correlate proxy and application logs by timestamp/request ID. Find the configured upstream and inspect listeners with `ss -lnt` or `ss -lx`. | Separate proxy, upstream and dependency failures. Connection refused suggests no accepting listener at that endpoint; timeout needs latency/connectivity evidence. Inspect the actual upstream service instead of guessing a versioned unit. |
| SSH / connectivity | From the affected client, record exact error, DNS answer and one bounded TCP/SSH probe. With server access, inspect addresses/routes (`ip addr`, `ip route`), the actual listener and relevant firewall rules. | Distinguish DNS failure, timeout, refusal and authentication failure. Client failure does not establish a dead host. If SSH is unavailable, request an authorized console/operator check; preserve existing access before network changes. |
| DNS / TLS | Compare expected hostname and resolver answers; check clock and certificate name, chain and expiry. For HTTPS, `curl --connect-timeout 5 --max-time 15 -I https://example.com` is a bounded header probe. | Use the real authorized endpoint. HEAD may differ from the failing request; repeat its method/path safely. Keep TLS verification enabled. Split resolver, TCP, TLS and application errors before renewal or config changes. |
| EACCES / permission denial | Inspect identity, ownership and each path component; on applicable systems check SELinux mode/AVCs or AppArmor denials in the incident window. | Attribute policy denial only with supporting evidence. Correct the specific owner, context or policy when authorized; preserve confinement and least privilege. A refusal alone does not prove SELinux caused it. |
| Deployment / database / recovery | Align the failure with release/config changes and dependency health; inspect connection errors, bounded application/database diagnostics and available recovery evidence. | Separate network, auth, locks, limits and migrations. Keep database writes, restore and rollback out of diagnosis-only work. Before recovery, identify backup validity, data-loss window and service-specific procedure. |

For systemd kernel evidence, use a bounded incident window, for example
`journalctl -k --since '30 minutes ago' -n 100 --no-pager`. If unavailable or
restricted, request accessible kernel/runtime logs. Avoid filtering solely by
error severity: useful context may be logged at other levels.

For deleted-open files, deleting the pathname again cannot release held blocks.
Quantify their contribution and identify the owning service. Propose its
documented log-reopen operation or a controlled restart only when appropriate
and authorized; cache cleanup is not evidence that this cause was resolved.

## 4. Make one justified change

Use the user's existing authorization and constraints. Diagnosis-only access
does not authorize mutation. A suggested fix is not evidence that it is correct.
Before a restart, config edit, package operation, cleanup, firewall change,
rollback or restore, establish:

- The evidence tying that action to the failing layer.
- The exact target, expected effect and service/data/access impact.
- A rollback or recovery path and a test that distinguishes success from failure.

If authority is missing, present that concrete proposal and request only the
missing authorization. When it already covers the action, proceed within it.
Preserve the relevant before-state, make one bounded change, then check its
effect. Avoid blind restarts, journal vacuuming, forced renewal, broad `chmod`,
disabled security controls and unrelated package installation as diagnostic defaults.

On failure or interruption, inspect current state before retrying; assume partial
success. Recover the previous state when safe and authorized, or state the
remaining recovery decision. Never imply deletion, restore or a migration is
automatically reversible.

## 5. Verify and report

Repeat the original user-visible test from the affected location, then check
the implicated service, dependency and resource. State the observation window;
a short recovery establishes current behavior, not permanent resolution.
Separate mitigation from a confirmed root cause. If access or evidence is
insufficient, leave the incident open and identify the next useful check.

Return a short report in the user's language:

- **Impact and scope:** affected target, symptom and onset/timezone.
- **Evidence:** commands actually run, relevant results and execution location.
- **Assessment:** supported cause or ranked hypotheses, confidence and gaps.
- **Action:** changes made or proposed, authority, recovery path and outcome.
- **Verification:** original test, subsystem checks, observation window and residual risk.

Before delivering, check every factual claim against collected evidence,
identify all mutations, and confirm the report distinguishes executed checks
from commands provided to an operator. Record incident learning only where
the project already keeps it or the user requests it; avoid unrequested artifacts.

Linux Troubleshooting: 8818x | MIT
