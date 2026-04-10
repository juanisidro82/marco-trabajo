# AI Agents Team Operating Model

## Overview: The Supervision Model

In this workflow, the **User acts as the Boss/Supervisor**. AI agents are not passive tools, but **specialized team members** operating under direct management. Success is not driven by a rigid prior plan (Architecture), but by the Supervisor's ability to direct execution and course-correct based on visible results.

---

## The Boss (User) — Direction and Criteria
- **Role:** Vision provider, prototype evaluator, and final decision-maker.
- **Style:** Bricolage / Exploratory. The Boss knows what they want when they see it working.
- **Responsibility:** Ensure agents do not drift from the objective and consolidate knowledge at the end of each session.

---

## Claude Code — Premium Auditor & Specialist
- **Profile:** Expert in logic, code structure, and deep technical reasoning.
- **When to assign a task:** 
  - High-level critical review and auditing.
  - Complex architectural decisions or trade-offs.
  - Risk assessment and final quality checks.
- **Working Style:** Do not ask for long plans; propose minimal prototypes or critical audits.
- **Strength:** Best at detecting gaps, edge cases, and UX risks.

---

## Gemini CLI — Stable Baseline & Context Analyst
- **Profile:** Employee with massive memory and high-volume processing capacity.
- **When to assign a task:**
  - Daily tasks, repeatable workflows, and baseline operations.
  - Analyzing many files at once to find patterns.
  - Maintaining full context for large projects that exceed other agents' windows.
- **Working Style:** Provide full context (docs + code) and request execution based on established rules.
- **Strength:** Consistent quality and operational continuity. Does not forget details.

---

## Codex CLI — Creative Builder
- **Profile:** Fast implementation, technical exploration, and rapid iteration.
- **When to assign a task:**
  - Coding, refactors, and fast fixes.
  - Turning ideas into concrete output quickly.
  - Rapidly iterating on a specific module or feature.
- **Working Style:** Short instructions, immediate execution. The "boots on the ground" for coding.
- **Strength:** Speed and focus on technical implementation.

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
- **Complementary Views:** It is better to have 3 complementary viewpoints under fixed cost and quality control than a single fast viewpoint with higher operational risk.
