# ELO Autonomy Readiness

## Target behavior

When a task objective is explicit, ELO should continue through decomposition, specialist review, implementation, correction, validation, merge and verification rather than stopping at a recommendation.

## Control loop

1. Objective clarity
2. Task specification
3. Codex execution
4. Specialist review
5. ELO architectural decision
6. Automatic correction when required
7. Revalidation
8. Gated merge
9. Post-merge verification
10. Terminal report

## Specialist lanes

- Architecture
- Security
- Data
- Operations
- Testing/QA
- Domain, when required

## Merge gate

Merge is permitted only after ELO emits `APPROVE_MERGE`, required specialist findings are resolved, acceptance criteria pass, configured required checks pass, scope is compliant, and repository protections are respected.

## Escalation

The agent stops only for an external decision, missing capability/credential, contradictory requirements, exhausted correction budget, or a repository protection that explicitly requires human approval.

## Implementation

The executable workflow is `.github/workflows/elo-agent-loop.yml` and the durable governance contract is `automation/ELO_CHAT_CODEX_BRIDGE.md`.
