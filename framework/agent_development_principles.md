# AI Agent Development Principles

This document captures principles learned while developing projects with AI agents. It is written to be read by AI agents at the start of a project to feed their memory and apply these principles from day one.

---

## Principle 1: Minimal LLM — Deterministic Logic in Code

The correct separation of responsibilities in a system with an LLM is:

| Layer | Responsibility |
|------|----------------|
| **LLM** | Detect intent, interpret natural language, decide which tool to call. |
| **Code (Python/etc.)** | Format responses, apply business rules, structure outputs. |

### Red Flag
When the system prompt starts filling up with formatting instructions, conditional rules, or output examples — that indicates that logic should move to code.

### Validated Solution
Replace formatting instructions in the prompt with **code templates**: the LLM calls the tool, the code takes the result and generates the final response.

```
User → LLM (intent) → Tool call → Python (template) → Response
```

### Benefit
- Deterministic and consistent responses.
- The prompt stays short and focused.
- The LLM cannot "invent" format or data.

---

## Principle 2: Feedback Cycle with Observable Outputs

The greatest development accelerator is for the programming agent to be able to **see outputs directly**, without depending on the user to describe them.

### Implementation
Instrument the bot with an automatic transcript (e.g., `session.log`) that records:
- Every user query.
- Every agent response.
- Timestamps.

### The Cycle
1. User tests the bot in an interactive session.
2. Programming agent reads the log.
3. Agent compares the real response against the expected one.
4. Agent identifies the gap and proposes a fix.
5. User approves → Commit → Next test.

### Why it matters
A previous development failed in 28 days due to ambiguous feedback cycles: the user described the problem with words, the agent interpreted it differently, something incorrect was generated, and the cycle repeated without progress. With observable outputs, the gap becomes evident in seconds.

---

## Principle 3: Infrastructure Before Execution

Before creating or modifying objects/data, verify that you know **how** to do it correctly.

- If an API or DB error occurs during execution → stop, diagnose, fix the client.
- Do not use session workarounds. Fix the base code.
- Document the finding before continuing.

**Milestone Types:**
- **Infrastructure Milestone:** the agent doesn't know how to perform the operation → stop, fix first.
- **Execution Milestone:** tools are working → execute the task.

If an error occurs during execution, the milestone changes to Infrastructure.

---

## Principle 4: Bounded Tool Payloads

Tools registered in the LLM must return only the necessary fields. A tool returning thousands of complete objects can exceed the model's token limit.

### Rules
- Always filter and paginate.
- Return only fields the LLM needs for reasoning.
- Never register a function as a tool that returns the entire dataset without filtering.

---

## Principle 5: User Development Style — Exploratory / Opportunistic Programming

The user does not start from prior specifications. They build to discover what they want to build. This style has solid academic roots and is cognitively valid — it is not an immature way of programming.

### Paradigms that describe it

| Term | Domain | Why it applies |
|---------|--------|----------------|
| **Exploratory Programming** | Academic (HCI/SE) | The most formally recognized. Sheil (1983): *"creating such programs is more a problem of exploration than implementation"*. |
| **Opportunistic Programming** | Stanford HCI (Brandt et al., 2008) | The most precise: impermanent code, rapid iteration, goal emerging from the process. |
| **Bricolage Programming** | Philosophy/education (Turkle & Papert, 1990) | The programmer *conversations with materials* instead of planning and executing. |
| **Spike (XP)** | Agile methodology (Kent Beck) | The only mainstream agile practice that formalizes disposable code as a discovery tool. |
| **Reflection-in-Action** | Philosophy of practice (Schon, 1983) | Experts think *while doing*, not before. |

### Why Spec-Driven Development doesn't work for this user

Spec-Driven assumes the goal can be specified before building. For this user, **seeing the result is part of the process of specifying it**.

---

## Principle 6: Context Consolidation at the End of Each Session

Once something is understood and validated, externalize it to the **repository** — not within the conversation, and not in the local memory system of the agent.

Consolidation methods:
- **Script:** if the agent knows how to execute a repeatable process, write it as a script.
- **Doc:** if a business rule or architectural decision was clarified, document it in `docs/`.
- **Prompt:** if a reusable prompt was developed, save it in `docs/prompts/`.
- **Refactor:** if a pattern repeated in the session, consolidate it into a reusable function.

The goal is for the next session to start with more context in code and docs, and less rebuilt from scratch.
