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
| Framework Doc | Location in Project |
|---------------|---------------------|
| user_profile | `docs/development/user_profile.md` |
| agent_development_principles | `docs/development/agent_development_principles.md` |
| ai_agents_team | `docs/development/ai_agents_team.md` |
| centaur_model | `docs/development/centaur_model.md` |
| quality_standards | `docs/development/quality_standards.md` |
| git_native_workflow | `docs/development/git_native_workflow.md` |
| docs_conventions | `docs/development/docs_conventions.md` |

## Propagation Notes
- `CLAUDE.md` has project-specific sections (LLM Wiki rules, scripts, frontmatter schema,
  FTS5 fields, operation rules) that must NOT be overwritten. Framework sections are marked
  with `<!-- FRAMEWORK_SECTION: id -->` comments.
- `GEMINI.md` follows a similar structure with richer detail — preserve all project-specific
  content when propagating.
- `CODEX.md` was created during initial propagation — update framework sections only.
- Framework docs in `docs/development/` are pure framework — can be fully replaced.

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
