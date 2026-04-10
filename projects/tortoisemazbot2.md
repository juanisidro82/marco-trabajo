# Project: tortoisemazbot2

## Path
`/home/isidro/herramientas/tortoisemazbot2/`

## Domain
Hostel/WiFi management bot. Manages client rentals, payment registration, router
blocking/unblocking, and overdue client auditing. Connects to a PostgreSQL database.
Exposes a web interface (Flask/FastAPI) for operators.

## Active LLMs
| LLM | Context File |
|-----|--------------|
| Claude Code | `CLAUDE.md` |
| Codex CLI | `CODEX.md` |
| Gemini CLI | `GEMINI.md` |

## Framework File Locations
| Framework Doc | Location in Project |
|---------------|---------------------|
| user_profile | `docs/development/perfil_usuario.md` |
| agent_development_principles | `docs/development/principios_desarrollo_agente.md` |
| ai_agents_team | `docs/development/ai_agents_team.md` |
| centaur_model | `docs/development/centaur_model.md` |
| quality_standards | `docs/development/quality_standards.md` |
| git_native_workflow | `docs/development/git_native.md` |

## Propagation Notes
- `CLAUDE.md` contains project-specific sections that must NOT be overwritten:
  - Framework-controlled sections (marked with `<!-- FRAMEWORK_SECTION: id -->`):
    - `user_profile` (Cognitive & Collaboration)
    - `approach` (Centaur Model)
    - `development_principles` (Tech Principles)
  - Language rules (Working: Spanish / Output: English)
  - Container Environment (Docker info)
  - Security check before any new script
- Framework docs in `docs/development/` are pure framework — can be replaced fully.
- `docs/auditor.md`, `docs/decisions.md`, `docs/glossary.md` are project-specific — never touch.
- `docs/runbooks/` and `docs/prompts/` are project-specific — never touch.

## Key Modules
- `app/auditor.py` — main auditor: scans DB for overdue clients, labels by state
- `scripts/register_payment.py` — register a full payment for a client
- `scripts/register_partial_payment.py` — register a partial payment
- `scripts/payment_operation.py` — shared payment logic
- `scripts/payment_preflight.py` — pre-payment validation checks
- `scripts/bloquear_router.py` / `scripts/desbloquear_router.py` — router management
- `scripts/iniciar_renta.py` — start a new rental for a client
- `scripts/reactivate_service.py` — reactivate a blocked service
