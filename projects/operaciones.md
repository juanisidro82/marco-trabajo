# Project: operaciones

## Path
`/home/isidro/operaciones/`

## Domain
Operational coordinator. LLM Wiki architecture (Karpathy, 2025): Markdown files as source
of truth + SQLite FTS5 as high-speed search index. Manages WISP field operations
(installations, technical visits, recoveries) and personal/work agenda organized in a
4-level time hierarchy (quinquenio / año / trimestre / quincena). Integrates with Anytype
as an external data source for migration.

## Active LLMs
| LLM | Context File |
|-----|--------------|
| Claude Code | `CLAUDE.md` |
| Gemini CLI | `GEMINI.md` |

> **Note:** `CODEX.md` is missing — required by framework. Must be created on next
> propagation cycle.

## Framework File Locations
Framework docs have not yet been placed in a dedicated subfolder. Currently, framework
content is embedded directly in `CLAUDE.md` and `GEMINI.md`.

| Framework Doc | Location in Project |
|---------------|---------------------|
| (embedded) | `CLAUDE.md` and `GEMINI.md` (mixed with project-specific content) |

## Propagation Notes
- `CLAUDE.md` is entirely project-specific (LLM Wiki rules, scripts, frontmatter schema,
  FTS5 fields, operation rules). Framework sections are not yet separated.
- `GEMINI.md` follows the same structure as `CLAUDE.md` with richer detail and emoji
  formatting — also project-specific.
- When propagating framework docs, prefer creating a `docs/` subfolder rather than
  overwriting root context files.
- `CODEX.md` needs to be created (can be seeded from `templates/CLAUDE_template.md`).

## Key Scripts
| Script | Purpose |
|--------|---------|
| `nueva_tarea.py` | Create operational task (installation/visit/recovery) |
| `nueva_agenda.py` | Create agenda item at any time level |
| `gestor_tareas.py` | Complete tasks, change type, move to agenda hierarchy |
| `indexador.py` | Rebuild FTS5 index from all `.md` files |
| `buscar.py` | Fast query against the index |
| `migrar_anytype.py` | Transform Anytype CSV export into local `.md` files |
| `periodos.py` | Internal library: quincena/trimestre/quinquenio calculations |

## Project Structure
```
operaciones/
├── tareas/          # Active operational tasks (instalaciones/visitas/recuperaciones)
├── agenda/
│   ├── 2021-2025/
│   └── 2026-2030/   # 4-level hierarchy: quinquenio/año/trimestre/quincena
├── rutinas/         # Master routine objects (ambito + frequencies)
├── procesos/        # Operational documentation
├── operaciones.db   # SQLite FTS5 index
└── *.py             # Management scripts
```
