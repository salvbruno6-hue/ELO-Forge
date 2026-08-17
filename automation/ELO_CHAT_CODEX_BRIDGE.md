# ELO Chat ↔ Codex Bridge v1

## Purpose

Establish the operating contract between the ELO governance layer in ChatGPT and Codex as the execution layer for repository work.

## Roles

- **ELO / ChatGPT:** analyze, decide, prioritize, define acceptance criteria, classify risk, and authorize the intended change.
- **GitHub:** durable task ledger and audit trail for the handoff.
- **Codex:** inspect the repository, implement the task, run validation, and report evidence.
- **Human owner:** approve high-risk architectural or production changes and final merges.

## Handoff protocol

1. ELO creates a task specification using `automation/tasks/ELO-TASK-*.yml`.
2. The task is linked to a GitHub Issue using the same task ID.
3. Codex consumes the issue/task specification, reads `AGENTS.md`, and executes only the declared scope.
4. Codex creates an isolated branch/worktree, implements the change, and runs the declared validation.
5. Codex opens a PR when implementation is complete. The PR must reference the task ID.
6. ELO reviews the result against the task acceptance criteria and architecture governance.
7. Merge requires the configured repository protections and human approval for high-risk changes.

## Task states

`PROPOSED → READY → IN_PROGRESS → VALIDATION → REVIEW → APPROVED → MERGED`

Failure path:

`IN_PROGRESS/VALIDATION → BLOCKED`

A blocked task must record the reason and the next required decision.

## Risk gates

### LOW

Documentation, formatting, non-functional organization, tests without production behavior changes.

Codex may implement and open a PR.

### MEDIUM

Application logic, schemas, APIs, automation, or dependency changes.

Codex may implement and open a PR; merge requires review.

### HIGH

Security, authentication/authorization, data deletion policy, production infrastructure, irreversible migrations, governance baseline changes, or changes to sovereign ELO rules.

Codex must stop before merge and request human/ELO approval.

## Non-negotiable rules

- Never write directly to `main` for task execution.
- Never merge a high-risk change automatically.
- Never silently expand task scope.
- Preserve auditability of task, branch, commit, PR, validation, and decision.
- Follow the repository `AGENTS.md` as the execution policy.
- If requirements conflict, stop and surface the conflict instead of guessing.

## Recommended task naming

`ELO-<DOMAIN>-<SEQUENCE>`

Examples:

- `ELO-ARCH-001`
- `ELO-SEC-001`
- `ELO-DATA-001`
- `ELO-AUTO-001`

## First implementation

The first bridge task is `ELO-ARCH-001`, which establishes the architectural governance artifacts required before Baseline v1.0 is frozen.
