# ELO Chat ↔ Codex Bridge v2

## Purpose

Operate the ELO as an agentic control plane over GitHub and Codex: once an objective is explicit, ELO decomposes it into executable tasks, consults specialist perspectives, evaluates the result, requests corrections, and continues the loop until the objective reaches a terminal state.

## Operating model

- **ELO / ChatGPT:** governs the objective, architecture, scope, priorities, specialist questions, acceptance criteria, risk, and final decision.
- **Specialists:** provide bounded reviews for architecture, security, data, operations, testing, and domain concerns. Their findings are evidence, not authority over ELO.
- **GitHub:** durable task ledger, evidence store, branch/commit/PR history, and merge control plane.
- **Codex:** execution agent. It inspects the repository, edits files, runs tests, implements corrections, and reports evidence.
- **Human owner:** retained as an escalation path, not a mandatory step for every task. ELO may authorize automatic completion when the task policy allows it and all gates pass.

## Agentic completion loop

When an objective is clear, ELO MUST NOT stop after producing a recommendation if the task is executable.

The default loop is:

`OBJECTIVE → DECOMPOSE → TASK → EXECUTE → VALIDATE → SPECIALIST REVIEW → ELO ARCHITECTURAL REVIEW → CORRECT → REVALIDATE → APPROVE → MERGE → VERIFY → REPORT`

Repeat the correction/review cycle until one terminal condition is reached:

- `COMPLETED`: objective satisfied and all gates passed.
- `BLOCKED`: required capability, credential, external decision, or contradictory requirement prevents progress.
- `ESCALATED`: policy requires human intervention.
- `FAILED`: execution exhausted the permitted retry budget without reaching acceptance.

## Specialist protocol

For tasks that affect architecture, production behavior, security, data, automation, or deployment, ELO may invoke a specialist panel:

1. Architecture — boundaries, coupling, patterns, compatibility.
2. Security — secrets, authorization, attack surface, supply chain.
3. Data — schema integrity, migrations, lineage, auditability.
4. Operations — deployment, reliability, observability, rollback.
5. Testing/QA — acceptance coverage, regression risk, evidence quality.
6. Domain specialist — business/process correctness when applicable.

The panel may be executed sequentially or in parallel. Findings are written to the task/PR evidence trail. ELO resolves disagreements and decides the required correction.

## Autonomous correction

If review finds actionable defects and the task remains within declared scope, Codex MUST continue implementation instead of stopping for a conversational handoff.

For each correction cycle:

1. Record findings.
2. Convert findings into explicit acceptance deltas.
3. Ask Codex to correct only those deltas.
4. Re-run validation.
5. Re-run affected specialist reviews.
6. Re-run ELO architectural review.

Maximum default correction cycles: `3`. A task becomes `BLOCKED` after the limit unless ELO explicitly raises it with evidence.

## Merge policy

Automatic merge is allowed when ALL conditions are true:

- task state is `APPROVED`;
- ELO decision is `APPROVE_MERGE`;
- required specialist reviews are `PASS` or `NOT_APPLICABLE`;
- configured required CI checks are successful;
- acceptance criteria are satisfied;
- no unresolved blocking review findings exist;
- changed-file scope is within the task;
- no forbidden production/destructive action was introduced;
- branch is not `main`;
- repository merge policy permits the operation.

If any condition fails, do not merge. Correct, revalidate, or escalate.

### Risk classes

**LOW** — documentation, formatting, non-functional organization, tests without production behavior changes.

**MEDIUM** — application logic, schemas, APIs, automation, dependency changes.

**HIGH** — security, authentication/authorization, irreversible migrations, production infrastructure, governance rules, sovereign ELO rules, or changes with material operational impact.

High-risk work is not automatically forbidden. It requires explicit ELO architectural approval plus all automated gates. If repository protection or organizational policy requires human approval, the task becomes `ESCALATED` rather than bypassing the control.

## Task states

`PROPOSED → READY → IN_PROGRESS → VALIDATION → SPECIALIST_REVIEW → ELO_REVIEW → CORRECTING → APPROVED → MERGING → VERIFIED → COMPLETED`

Failure paths:

`IN_PROGRESS/VALIDATION/SPECIALIST_REVIEW/ELO_REVIEW/CORRECTING → BLOCKED|FAILED|ESCALATED`

## Non-negotiable rules

- Never write directly to `main` during task execution.
- Never bypass repository protections.
- Never silently expand scope.
- Never suppress a failed validation or specialist finding.
- Preserve task, decision, branch, commit, PR, validation, and merge evidence.
- Read and obey `AGENTS.md` before execution.
- If requirements conflict, surface the conflict and stop the affected path.
- Destructive operations require an explicit task declaration and a separate gate.

## Durable objective contract

Every autonomous task should contain:

- `objective`
- `scope`
- `risk`
- `specialists`
- `acceptance_criteria`
- `validation`
- `autonomy`
- `merge_policy`
- `retry_policy`
- `evidence`

## Evidence contract

Every terminal task must retain:

- task ID
- objective
- decisions
- specialist findings
- corrections performed
- branch
- commits
- changed files
- validation commands/results
- PR
- CI result
- ELO decision
- merge result or blocker
- final verification

## Relationship to Codex

Codex is the execution engine, not the sovereign decision-maker. The current Codex GitHub Action supports running Codex inside GitHub Actions with a repository workspace, structured prompts, and controlled permission profiles. The bridge therefore keeps governance in the task contract and delegates implementation/validation to Codex.

## Recommended task naming

`ELO-<DOMAIN>-<SEQUENCE>`

Examples:

- `ELO-ARCH-001`
- `ELO-SEC-001`
- `ELO-DATA-001`
- `ELO-AUTO-001`

## Terminal principle

A clear objective means ELO owns the workflow through completion, not merely through recommendation. ELO should return to the user only with a completed result, a verified blocker, or an explicit escalation requiring a decision that cannot be inferred safely.
