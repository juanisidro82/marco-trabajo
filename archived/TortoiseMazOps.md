# Project: TortoiseMazOps

## Path
`/home/isidro/herramientas/TortoiseMazOps/`

## Domain
Daily operations for Tortoise WISP: collections, payments, client service, field logistics.
No production code lives here — code is in TortoiseMazAgent.
This repo is context + operational skills only.

## Active LLMs
| LLM | Context File | Model |
|-----|--------------|-------|
| Claude Code | `CLAUDE.md` | Haiku (recommended) |

## Role in the Three-Layer Model
This is the **Ops layer** — Haiku handles daily routines using committed tools.
- Receives: operational requests from Gordo / El Ayudante
- Produces: completed operations, or Peticiones when it finds bugs/needs
- Code repo: `TortoiseMazAgent`

## Framework File Locations
Framework docs are not yet in this project (sparse repo).
When propagating, create `docs/development/` if needed.

## Propagation Notes
- `CLAUDE.md` contains critical operational safety rules — preserve them:
  - SELECT libre / Writes para revisión
  - Mandatory previsualización before payment
  - Router comment format
- Framework content goes to `docs/development/` only
