# Quality Standards: Cross-Agent Validation

## Purpose

LLMs are non-deterministic — the same prompt can produce different interpretations across models or even across sessions. The **Triple Consensus Test** is an occasional tool the Supervisor uses to compensate for that randomness, not a mandatory gate on every task.

---

## The Triple Consensus Test

Run the same prompt or rule across the three agents and compare their interpretations:

1.  **Gemini** — baseline clarity check: if Gemini parses it without hallucinating, the instruction is well-structured.
2.  **Claude** — audits for edge cases and logical gaps.
3.  **Codex** — verifies the instruction is actionable and translates to working code.

Most sessions use only one agent. The test is reserved for moments where non-determinism matters.

---

## When to use Cross-Agent Validation

- **Ambiguity Detection:** When a session fails, re-run the same prompt across agents to find where interpretation diverged.
- **Defining Permanent Rules:** Before adding a rule to `CLAUDE.md` or `GEMINI.md` that all agents must follow.
- **Non-obvious Architecture Decisions:** When the correct implementation path is genuinely unclear.

---

## Success Criteria

- **Consensus:** All three agents propose the same logic or interpretation. → **Action: Merge into Framework.**
- **Friction:** One agent interprets the prompt differently. → **Action: The Supervisor refines the prompt to eliminate ambiguity.**
- **Failure:** All three interpret it differently. → **Action: The Supervisor stops, re-evaluates the intent, and restarts the Bricolage cycle.**

---

## Operational Goal
The goal of this team is to convert **vague intentions** into **explicit instructions** so clear that any team member can execute them with 100% predictability.
