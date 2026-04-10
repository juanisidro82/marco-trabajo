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
| user_profile | `docs/development/user_profile.md` |
| agent_development_principles | `docs/development/agent_development_principles.md` |
| ai_agents_team | `docs/development/ai_agents_team.md` |
| centaur_model | `docs/development/centaur_model.md` |
| quality_standards | `docs/development/quality_standards.md` |
| git_native_workflow | `docs/development/git_native_workflow.md` |

## Propagation Notes
- `CLAUDE.md` contains project-specific sections that must NOT be overwritten:
  - Framework-controlled sections (marked with `<!-- FRAMEWORK_SECTION: id -->`):
    - `user_profile` (Cognitive & Collaboration)
    - `approach` (Centaur Model)
    - `development_principles` (Tech Principles)
  - Session Startup Protocol (mandatory file reading order)
  - Milestone Distinction (Infrastructure vs Execution)
  - Project Structure
  - Anytype Environment (port, API prefix, space ID)
  - Command reference table
  - Coding Standards (Project-specific rules)
- `GEMINI.md` also contains project-specific Anytype domain model — do not overwrite.
- Framework docs in `docs/development/` are pure framework — can be replaced fully.
- `docs/runbooks/` and `docs/prompts/` are available for project-specific operational artifacts.

## Key Modules
- `agenda.py` — generic Anytype API client (list, get, create, update, delete, search)
- `periods.py` — period management (day, quincena, quarter, year, quinquenio)
- `anytype_agent.py` — LLM agent interface
