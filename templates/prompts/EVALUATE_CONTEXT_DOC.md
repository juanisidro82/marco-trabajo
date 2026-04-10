# Prompt Template: Context Artifact Evaluation

**Goal:** Use this prompt when introducing a large, dense documentation file (like `auditor.md` or a technical manual) to a team member. It ensures the agent understands the operational logic before executing any task.

---

## The Prompt (Copy & Paste to Agent)

"I am providing you with a critical context artifact: **[File Name/Path]**. 

As a member of this Supervisor-led team, your task is to 'ingest' this document and report back to me (The Supervisor) before taking any action.

### Evaluation Criteria:
1. **Executive Summary:** Provide the 3-5 most important operational rules or workflows described in this document.
2. **Command Readiness:** List the primary CLI commands or tools mentioned. Verify if they are ready for execution in the current environment.
3. **Constraint Identification:** What are the 'Invariants' or safety rules I must be aware of? (e.g., 'Always run dry-run first', 'Never delete X').
4. **Framework Alignment:** Does this document conflict with our core principles (`user_profile.md`, `centaur_model.md`)?
5. **Missing Info:** Is there any ambiguity in this document that requires my clarification before we proceed?

**Do not execute any code yet.** Provide your analysis in 5-8 bullet points. Once I approve your understanding, we will move to the Execution phase."
