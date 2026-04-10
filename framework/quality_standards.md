# Quality Standards: Cross-Agent Validation

## The Universal Clarity Rule
A rule, instruction, or business logic is only considered **Stable** when it passes the **Triple Consensus Test**.

> **"If Gemini understands the rule, any model understands it. If all three agents understand it the same way, the instruction is bulletproof."**

---

## The Triple Consensus Test (The Boss's Lever)

The Supervisor (The Rider) uses the three agents to validate the robustness of the team's "memory":

1.  **The Gemini Standard (Baseline):** Gemini CLI acts as the clarity benchmark. Because of its stable and literal nature, if Gemini can parse an instruction without hallucinating, the instruction is well-structured.
2.  **The Claude Audit (Sanity):** Claude Code checks for edge cases and logical gaps that the other two might miss.
3.  **The Codex Verification (Practicality):** Codex CLI ensures the instruction is actionable and translates directly into working code.

---

## When to use Cross-Agent Validation

- **Defining New Business Rules:** Before adding a permanent rule to `CLAUDE.md` or `GEMINI.md`.
- **Complex Refactoring:** When the implementation path is non-obvious.
- **Ambiguity Detection:** When a session fails, the Supervisor re-runs the same prompt across the three agents to find where the communication broke down.

---

## Success Criteria

- **Consensus:** All three agents propose the same logic or interpretation. → **Action: Merge into Framework.**
- **Friction:** One agent interprets the prompt differently. → **Action: The Supervisor refines the prompt to eliminate ambiguity.**
- **Failure:** All three interpret it differently. → **Action: The Supervisor stops, re-evaluates the intent, and restarts the Bricolage cycle.**

---

## Operational Goal
The goal of this team is to convert **vague intentions** into **explicit instructions** so clear that any team member can execute them with 100% predictability.
