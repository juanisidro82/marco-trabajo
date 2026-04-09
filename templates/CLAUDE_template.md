# CLAUDE.md — [Project Name]

## Language

**Working language: Spanish.** Conversation with the user always in Spanish.

**Output language: English.** All generated artifacts must be in English:
- Documentation and files in `docs/`
- Code comments and docstrings
- Commit messages
- Prompts in `docs/prompts/`
- Any content intended to be read by an LLM in a future session

Exception: user-facing UI strings and client-visible content stay in Spanish.

---

## Approach

Think before acting. Read existing files before writing code.
Be concise in output but thorough in reasoning.
Prefer editing over rewriting whole files.
Do not re-read files you have already read unless the file may have changed.
Test your code before declaring done.
No sycophantic openers or closing fluff.
Keep solutions simple and direct.
User instructions always override this file.

---

## User Profile

See `docs/development/perfil_usuario.md` for the full cognitive and collaboration profile.

Key points:
- Cannot specify what they want before seeing it — build minimal, show, adjust
- Specification emerges from contact with the material
- Short cycles: build → show → adjust, not plan → approve → implement
- Observable outputs are the communication channel: read logs and evidence, don't wait for verbal descriptions

---

## Development Principles

See `docs/development/principios_desarrollo_agente.md` for the full list.

Key principles:
1. LLM minimal — deterministic logic in code, not in prompts
2. Feedback cycle with observable outputs (session.log or equivalent)
3. Infrastructure before execution — fix the module before continuing
4. Bounded tool payloads — filter before returning to the LLM
5. Exploratory/Opportunistic Programming — treat initial code as disposable

---

## Security Check Before Any New Script

Before writing any script that reads, writes, or moves customer data, explicitly answer:
1. **What data does it touch?** — names, IDs, amounts, sensitive fields?
2. **Where does it write output?** — DB, file, log, console?
3. **Who can see that output?** — only the operator, or could it reach a repo or shared log?

---

## Project Structure

[Describe the main directories and their purpose]

```
[project-root]/
  [module or app dir]/   # [description]
  scripts/               # Operational scripts (one action per script)
  docs/
    development/         # Framework docs (propagated from marco_trabajo)
    [domain docs]        # Project-specific documentation
```

---

## Session Startup Protocol

[List what the agent MUST read before acting in a session]

1. This file (`CLAUDE.md`)
2. `docs/[main domain doc]` — [what it contains]
3. [any other mandatory files]

---

## Domain Context

[Describe the business domain, key entities, and rules]

### Key Entities
- **[Entity 1]:** [description]
- **[Entity 2]:** [description]

### Business Rules
- [Rule 1]
- [Rule 2]

---

## Key Scripts / Modules

| Script / Module | Purpose |
|-----------------|---------|
| `[path/to/script.py]` | [what it does] |

---

## Database / API

[Describe connection details (without credentials), key tables/endpoints]

- **Connection:** via `[method]` (credentials in `.env`)
- **Key tables:** `[table1]` ([purpose]), `[table2]` ([purpose])

---

## Coding Standards

- **Python:** [relevant standards for this project]
- **Git:** Conventional commits. Never stage `.env`.
- **[Other standards specific to this project]**
