# AI Agents Team Operating Model

## Overview: The Supervisor-led Team

This repository operates under the **Centaur Model** (see `centaur_model.md`). In this framework, the **User is the Boss/Supervisor**, acting as the "Rider" who directs a specialized team of AI "Team Members" (The Horse).

Success is evaluated by **results and observable evidence**, not by following a prior plan. The Supervisor delegates tasks based on each team member's specific strengths and "salary" level (model tier).

---

## The Supervisor (The Rider)
- **Role:** Sets the vision, evaluates performance, and provides course correction.
- **Style:** Bricolage. He knows what is needed once he sees it functioning.
- **Levers:** Subscription tier management, task allocation, and cross-review orchestration.

---

## Team Members (The Horse)

### Claude Code — Premium Auditor
- **Role:** Deep logic review, risk assessment, and auditing complex changes.
- **When to use:** Final verification, edge-case detection, or architecture-heavy refactors.
- **Level:** Premium tier (e.g., Sonnet/Opus).

### Gemini CLI — Stability & Context Analyst
- **Role:** Consistent execution, large-scale context handling, and operational continuity.
- **When to use:** Maintenance, repeatable workflows, and maintaining the project's "big picture".
- **Level:** Stable baseline (e.g., Gemini Pro/Ultra).

### Codex CLI — Creative Builder & Rapid Prototyper
- **Role:** Fast coding, technical exploration, and converting intent into code immediately.
- **When to use:** Rapid iteration cycles, implementation of new features, and "boots on the ground" coding.
- **Level:** Fast execution tier.

---

## Cross-Review Protocol
To leverage the team's diversity, the Supervisor may request a **Cross-Review**:
1. **Gemini** creates the baseline.
2. **Codex** implements the feature.
3. **Claude** audits for risks and edge cases.
4. **The Supervisor** approves the final result.

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
- **Mandatory Session Report:** Every working session must conclude with a structured report generated via `./scripts/new_session_report.sh`. This report serves as the official handoff for the next agent or session.

### Session Reporting Standard
The report must include:
- **Operational Rationale:** Why this work was prioritized.
- **Technical Rationale:** Implementation decisions and tradeoffs.
- **Validation Evidence:** Commands or logs proving the fix works.
- **Cross-Review Request:** Explicit instructions for the next agent (e.g., "Claude Code to audit security").
- **Complementary Views:** It is better to have 3 complementary viewpoints under fixed cost and quality control than a single fast viewpoint with higher operational risk.
