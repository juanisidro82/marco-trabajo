# Project: TortoiseMazAgent (+ Tortoise)

## Paths
- Primary: `/home/isidro/herramientas/TortoiseMazAgent/`
- Unified repo: `/home/isidro/herramientas/Tortoise/` (same CLAUDE.md, same lib/)

## Domain
CLI agents for Tortoise WISP — a rural ISP in Mazatlán Villa de Flores, Oaxaca.
Manages clients, payments, rentals, MikroTik access control, CPE/antenna management,
and field logistics. Multi-agent architecture: 7 specialized agents.

## Active LLMs
| LLM | Context File | Model |
|-----|--------------|-------|
| Claude Code | `CLAUDE.md` | Sonnet (Dev) |
| Gemini CLI | `GEMINI.md` | — |

## Framework File Locations
Framework docs are not yet migrated to this project.
When propagating, create `docs/development/` and place framework files there.

| Framework Doc | Target Location |
|---------------|----------------|
| perfil_usuario | `docs/development/perfil_usuario.md` |
| principios_desarrollo_agente | `docs/development/principios_desarrollo_agente.md` |
| roles_de_herramientas | `docs/development/roles_de_herramientas.md` |
| vibe_coding_profesional | `docs/development/vibe_coding_profesional.md` |
| git_native | `docs/development/git_native.md` |
| pycharm_practicas | `docs/development/pycharm_practicas.md` |
| modelo_por_capa | `docs/development/modelo_por_capa.md` |
| protocolo_blueprint | `docs/development/protocolo_blueprint.md` |

## Propagation Notes
- `CLAUDE.md` is dense with project-specific content — do NOT overwrite sections:
  - Stack table
  - Mapa del código (file inventory)
  - Funciones clave de postgres.py
  - Reglas de operación (safety rules — keep as-is, they're project-specific)
  - Los 7 agentes / Actores del negocio
  - Estado actual del proyecto
  - Protocolo Blueprint (already in CLAUDE.md — update if framework version changes)
- Framework content goes to `docs/development/` only
- `GEMINI.md` is a pointer to CLAUDE.md + CONTEXT.md — do not overwrite

## Key Modules
- `lib/db/postgres.py` — main DB interface (being modularized)
- `lib/mikrotik.py` — MikroTik router control
- `lib/ubiquiti.py` / `lib/ubiquiti_m.py` — AirOS 8/6 CPE management
- `mcp_server.py` — MCP server exposing ~40 tools for Claude Code
- `bot.py` — interactive terminal bot with LiteLLM tool calling
- `scripts/auditoria/auditor.py` — DB ↔ MikroTik cross-check
- `config/agentes.yaml` — agent personalities and config
