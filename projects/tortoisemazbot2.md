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

## Framework File Locations
| Framework Doc | Location in Project |
|---------------|---------------------|
| perfil_usuario | `docs/development/perfil_usuario.md` |
| principios_desarrollo_agente | `docs/development/principios_desarrollo_agente.md` |
| roles_de_herramientas | `docs/development/roles_de_herramientas.md` |
| vibe_coding_profesional | `docs/development/vibe_coding_profesional.md` |
| git_native | `docs/development/git_native.md` |
| pycharm_practicas | `docs/development/pycharm_practicas.md` |

## Propagation Notes
- `CLAUDE.md` contains project-specific sections that must NOT be overwritten:
  - Language rules (Working: Spanish / Output: English)
  - Approach section
  - User Profile section (can be updated if perfil_usuario.md changes)
  - Development Principles (can be updated if principios_desarrollo_agente.md changes)
  - Security check before any new script
- `docs/development/` files are pure framework — can be replaced fully.
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
