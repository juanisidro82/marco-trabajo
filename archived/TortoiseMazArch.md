# Project: TortoiseMazArch

## Path
`/home/isidro/herramientas/TortoiseMazArch/`

## Domain
Architecture and strategy sessions for Tortoise WISP.
This repo is for system decisions, new agent design, and resolving blockers
that Sonnet cannot resolve alone. No production code lives here.

## Active LLMs
| LLM | Context File | Model |
|-----|--------------|-------|
| Claude Code | `CLAUDE.md` | Opus (recommended) |

## Role in the Three-Layer Model
This is the **Arch layer** — Opus takes decisions, generates ADRs, designs before building.
- Receives: Decisiones escalated from Sonnet (TortoiseMazAgent)
- Produces: ADRs, implementation plans for Sonnet
- Code repo: `TortoiseMazAgent`

## Framework File Locations
Framework docs are not yet in this project (very sparse repo).
When propagating, create `docs/development/` if needed.

## Propagation Notes
- `CLAUDE.md` is mostly framework/meta content — can be updated freely
- Preserve: strategic context section (competitive advantage, growth model)
- Preserve: three-layer architecture diagram
