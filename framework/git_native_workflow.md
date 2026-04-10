# Git-Native: Analysis for Supervisor-led Workflows

## What Git-Native Means

A team member is git-native when it **automatically commits every change it makes**, instead of leaving modified files for the Supervisor to decide when to commit.

```
Normal team member:      modifies files → Supervisor decides when and what to commit.
Git-native team member:  modifies files → automatically commits → Supervisor reviews later.
```

Aider is the best-known example of a git-native team member by design.

---

## Advantages

**Granular Reversibility**
If a team member breaks something at step 7 of 20, the Supervisor can `git revert` to exactly step 6. Without git-native, the Supervisor has to manually rebuild from the last manual commit.

**Team Member Audit Trail**
The history shows exactly what the team member did, in what order, and which files it touched in each step. Useful for understanding why something stopped working after a long session.

**Protection Against Session Crashes**
If a session crashes unexpectedly, the work up to that point is preserved in commits.

---

## Disadvantages

**Contaminated History**
20 commits from a team member to complete a task that should be 1 clean commit. The `git log` stops being readable as project history and becomes an internal operations log of the team's work.

**Incorrect Commits Exist Permanently**
If a team member commits an error before detecting it, that commit exists in history even if later reverted. With manual pre-commit review by the Supervisor, the error never reaches history.

**Loss of Control Over Messages**
Generated messages describe the "what" but not the "why".

```
# Git-native team member commit
feat: update line 47 of module.py

# Supervisor-controlled commit
refactor: migrate payment module to OOP with explicit validation and session protocol
```

The second has semantic value as project history. The first is noise.

---

## Comparison with Current Flow

The current flow is **manually git-native but under Supervisor control**:

```
Team member acts → Manual review → Commit with semantic message.
```

This provides the advantages of git-native (reversibility, checkpoint) without the disadvantages (contaminated history, loss of message control).

---

## Conclusion

Git-native is valuable when a team member works autonomously for long periods without supervision. In a workflow with active **Supervisor management** and clear milestones, it adds noise without adding real protection.

**The team of Claude Code + Gemini CLI + Codex CLI under Supervisor management with manual commits per milestone is equivalent to git-native with quality control.**

### Milestone Rule
To avoid data loss in long sessions, follow this rule:
> **Commit at the end of each milestone (Infrastructure or Execution), not just at the end of the full session.**
