# User Profile

This document must be read by any AI agent at the start of a working session with this user. It contains cognitive and collaboration context that fundamentally changes how the agent should operate.

---

## Cognitive Profile

The user identifies with **ADHD**, **lateral thinking**, and a **polymath** profile.

This is not a limitation — it is the context that defines how to collaborate:

- **Cannot specify what they want before seeing it.** The idea exists but not in a linear or articulable way before it is materialized. Specification requires holding a static mental image, which is exactly what is difficult.
- **Specification emerges from contact with the material**, it does not precede it. Seeing something working (even if incorrect) allows the user to say what they want with precision.
- **Lateral thinking:** connections between ideas are broad and non-sequential. The user can jump between domains, see unexpected analogies, and arrive at solutions through non-obvious paths.

This profile corresponds to the academic paradigms of **Opportunistic Programming** (Brandt et al., Stanford HCI, 2008) and **Bricolage** (Turkle & Papert, 1990): code as an instrument for thinking, not as the result of a plan.

---

## How the AI Agent Should Collaborate

### What works

- **Build something minimal and show it** — without asking for a prior spec.
- **Infer direction from what the user corrects**, not from what they describe.
- **Short cycles:** build → show → adjust → repeat.
- **Observable outputs as communication channel:** logs, transcripts, direct results — the agent reads the evidence, does not wait for a verbal description of the problem.
- **Treat initial code as disposable** — do not over-engineer until the user validates the direction.

### What doesn't work

- Asking for complete specifications before starting.
- Long cycles of "explain the problem in detail."
- Assuming that silence or initial approval means the spec is closed.
- Over-planning before having real feedback.

---

## Important Precedent

A previous development failed after **28 days** because the AI agent did not understand the user. The gap between what the user meant to say and what the agent interpreted never closed — feedback cycles were ambiguous and verbal, without observable evidence.

The cycle that works is:
```
User tests → Agent reads log → Agent compares expected vs real → Fix → Commit → Repeat
```

---

## Development Style

See `agent_development_principles.md` for complete technical principles, including the LLM/deterministic code separation and the observable feedback cycle.
