# Project: agenda

## Path
`/home/isidro/agenda/`

## Domain
Personal productivity tool. Python interface for reading and writing objects in Anytype
(a local-first PKM app). Manages tasks, goals, and time periods (day, quincena, quarter, year).
Backend: Anytype CLI (`anytype serve`) on port `31012`.

## Active LLMs
| LLM | Context File |
|-----|--------------|
| Claude Code | `CLAUDE.md` |
| Codex CLI | `CODEX.md` |
| Gemini CLI | `GEMINI.md` |

## Framework File Locations
| Framework Doc | Location in Project |
|---------------|---------------------|
| user_profile | `docs/perfil_usuario.md` |
| agent_development_principles | `docs/principios_desarrollo_agente.md` |
| ai_agents_team | `docs/vibe/ai_agents_team.md` |
| centaur_model | `docs/vibe/centaur_model.md` |
| quality_standards | `docs/vibe/quality_standards.md` |
| git_native_workflow | `docs/vibe/git_native.md` |

## Propagation Notes
- `CLAUDE.md` contains project-specific sections that must NOT be overwritten:
  - Session Startup Protocol (mandatory file reading order)
  - Milestone Distinction (Infrastructure vs Execution)
  - Project Structure
  - Anytype Environment (port, API prefix, space ID)
  - Command reference table
  - Coding Standards (only this section may reference the framework)
- `GEMINI.md` also contains project-specific Anytype domain model — do not overwrite.
- Framework docs in `docs/vibe/` are pure framework — can be replaced fully.
- `docs/perfil_usuario.md` and `docs/principios_desarrollo_agente.md` are pure framework — can be replaced fully.

## Key Modules
- `agenda.py` — generic Anytype API client (list, get, create, update, delete, search)
- `periods.py` — period management (day, quincena, quarter, year, quinquenio)
- `anytype_agent.py` — LLM agent interface
