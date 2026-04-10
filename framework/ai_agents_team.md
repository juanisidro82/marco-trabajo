# AI Agents Team Operating Model

## Overview: The Supervisor-led Team

This repository operates under the **Centaur Model** (see `centaur_model.md`). In this framework, the **User is the Boss/Supervisor**, acting as the "Rider" who directs a specialized team of AI "Team Members" (The Horse).

Success is evaluated by **results and observable evidence**, not by following a prior plan. The Supervisor delegates tasks based on each team member's specific strengths.

---

## The Supervisor (The Rider)
- **Role:** Sets the vision, evaluates performance, and provides course correction.
- **Style:** Bricolage. He knows what is needed once he sees it functioning.
- **Levers:** Task allocation and cross-review orchestration.

---

## Team Members (The Horse)

### Claude Code — Auditor & Logic Reviewer
- **Role:** Deep logic review, risk assessment, and auditing complex changes.
- **When to use:** Final verification, edge-case detection, or architecture-heavy refactors.

### Gemini CLI — Stability & Context Analyst
- **Role:** Consistent execution, large-scale context handling, and operational continuity.
- **When to use:** Maintenance, repeatable workflows, and maintaining the project's "big picture".

### Codex CLI — Complementary Builder
- **Role:** Fast coding and technical exploration. Codex approaches problems differently than Claude — they complement each other rather than duplicate effort.
- **Context Artifact:** `CODEX.md` (Manual reference). Since Codex does not load instructions automatically, the Supervisor should provide the contents of `CODEX.md` at the start of the session to set context.
- **When to use:** Rapid iteration cycles, implementation of new features, and as a second perspective when Claude's approach needs a counterpoint.

---

## Cross-Review Protocol
To leverage the team's diversity, the Supervisor may request a **Cross-Review**:
1. **Gemini** creates the baseline.
2. **Codex** implements the feature.
3. **Claude** audits for risks and edge cases.
4. **The Supervisor** approves the final result.

---

## Lifecycle: Validate, Build, Automate
To ensure high-quality delivery without rework, every task follows this cycle:
1.  **Validate (Infrastructure):** Ensure the bridge/artefact (API, DB, client) works as expected through a cross-review. No production code is written until the material is validated.
2.  **Build (Execution):** Agents implement the logic based on the validated artefact, using logs and observable evidence to self-correct during the process.
3.  **Automate/Handoff:** Once the functionality is stable and logs show consistent success, the task is considered done. The agent then moves to the next task, leaving behind a stable system.

---

## Supervision Workflow (Bricolage-Friendly)

1. **Initiative (Boss):** "I want to try X, build something minimal so I can see it."
2. **Prototyping (Agent):** The agent builds and shows (logs, code, observable output).
3. **Review (Boss):** The Boss observes the result. "This works, this doesn't. Change Y."
4. **Adjustment (Agent):** The agent refines based on observable evidence.
5. **Approval & Consolidation (Boss):** Once it works, the agent performs a commit and documents findings to avoid future rework.

---

## Team Culture & Ethics

- **No Over-Planning:** Agents should prefer building prototypes over asking for extensive specifications.
- **Error as Evidence:** If something fails, show the error/log immediately. The Boss uses evidence to clarify direction.
- **Knowledge Consolidation:** At the end of a session, agents must update the team's "memory" (docs/scripts) so the Boss doesn't have to repeat instructions.
- **Session Reports (Optional):** For long implementation sessions or when the Supervisor explicitly requests a handoff document, generate a report via `./scripts/new_session_report.sh`. For short, specific-query sessions, a semantic commit message is sufficient.

### Session Reporting Standard
Session reports are **optional**. Use them only for long implementation sessions or when the Supervisor explicitly requests a handoff document. For short, specific-query sessions, a commit with a semantic message is sufficient.

When a report is written, it must include:
- **Operational Rationale:** Why this work was prioritized.
- **Technical Rationale:** Implementation decisions and tradeoffs.
- **Validation Evidence:** Commands or logs proving the fix works.
- **Cross-Review Request:** Explicit instructions for the next agent (e.g., "Claude Code to audit security").

`reports/sessions/` and `archived/` are **historical reference directories** — read-only. Agents should only read them when the Supervisor asks to analyze past work.
