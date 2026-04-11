# Docs Conventions

Standards for organizing documentation within registered projects.

---

## Roadmaps

### Location

All roadmaps live under `docs/roadmaps/` in the project root. No roadmap files outside this folder.

### Status classification

Roadmaps are classified by status using subfolders:

```
docs/roadmaps/
  pending/    # in-progress or not yet started
  done/       # fully completed
```

When a roadmap is finished, move it from `pending/` to `done/` and commit.

### Naming

Use lowercase, hyphen-separated names that describe the initiative:

```
docs/roadmaps/pending/session_agent_split.md
docs/roadmaps/pending/agent_memory.md
docs/roadmaps/done/reconstruccion.md
```

### One file per initiative

Each roadmap covers a single feature, refactor, or initiative. Do not merge unrelated roadmaps into one file.

---

## General docs structure

Organize `docs/` by topic using subfolders. Do not mix categories at the root level:

```
docs/
  roadmaps/        # roadmaps (see above)
  development/     # framework docs (user_profile, ai_agents_team, etc.)
  anytype/         # provider-specific docs (agenda only)
  prompts/         # prompt templates for agents
  runbooks/        # operational step-by-step guides
```

Add new subfolders when a new category of docs emerges. Avoid flat accumulation at `docs/`.
