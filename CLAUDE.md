# marco_trabajo — Central Workflow Framework

This repository is the **single source of truth** for the user's development workflow, tool roles,
and AI collaboration principles. It applies to all projects.

## Purpose

When the user discovers a better way of working in any project, they update this repo.
Claude then propagates the relevant changes to the registered projects.

## How to Propagate Changes

When asked to propagate a change to one or more projects:

1. Read the updated framework file in `framework/`
2. Read the target project's context file in `projects/<project>.md` to understand:
   - Where the framework files live in that project
   - What LLMs are active and which context files they use
   - Any project-specific constraints
3. Read the current version of the target file in the project
4. Update it intelligently — merge, adapt, do not blindly overwrite
5. Preserve project-specific content that is not part of the framework
6. Repeat for each registered project

## Registered Projects

| Project | Path | Context File |
|---------|------|--------------|
| agenda | ~/agenda/ | projects/agenda.md |
| tortoisemazbot2 | ~/herramientas/tortoisemazbot2/ | projects/tortoisemazbot2.md |

## Repository Structure

```
framework/                  # Canonical framework docs — edit these, not the copies
  perfil_usuario.md
  roles_de_herramientas.md
  git_native.md
  principios_desarrollo_agente.md
  modelo_por_capa.md
  protocolo_blueprint.md
  pycharm_practicas.md
templates/
  CLAUDE_template.md        # Skeleton for new projects
projects/
  agenda.md                 # Context + file mapping for agenda
  tortoisemazbot2.md        # Context + file mapping for tortoisemazbot2
archived/                   # Abandoned projects and methodologies
```

## Adding a New Project

1. Create `projects/<project-name>.md` describing:
   - Absolute path to the project
   - Active LLMs and their context file locations
   - Where framework docs live (or should live) in the project
   - Brief domain description
2. Add the project to the table above in this file
3. Run initial propagation: ask Claude to seed the framework into the new project

## Language

- This file and `projects/*.md`: English (read by LLMs)
- `framework/*.md`: Spanish (matches existing docs across projects)
- `templates/CLAUDE_template.md`: English (template for LLM context files)
