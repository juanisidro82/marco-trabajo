# Git-Native: Analysis for AI Agent Workflows

## What Git-Native Means

An agent is git-native when it **automatically commits every change it makes**, instead of leaving modified files for the human to decide when to commit.

```
Normal agent:      modifies files → human decides when and what to commit.
Git-native agent:  modifies files → automatically commits → human reviews later.
```

Aider is the best-known example of a git-native agent by design.

---

## Advantages

**Granular Reversibility**
If the agent breaks something at step 7 of 20, you can `git revert` to exactly step 6. Without git-native, you have to manually rebuild from the last manual commit.

**Agent Audit Trail**
The history shows exactly what the agent did, in what order, and which files it touched in each step. Useful for understanding why something stopped working after a long session.

**Protection Against Session Crashes**
If the agent crashes unexpectedly in the middle of a long session, the work up to that point is preserved in commits.

---

## Disadvantages

**Contaminated History**
20 agent commits to complete a task that should be 1 clean commit. The `git log` stops being readable as project history and becomes an internal operations log of the agent.

**Incorrect Commits Exist Permanently**
If the agent commits an error before detecting it, that commit exists in history even if later reverted. With manual pre-commit review, the error never reaches history.

**Loss of Control Over Messages**
Agent-generated messages describe the "what" but not the "why".

```
# Git-native agent commit
feat: update line 47 of module.py

# Human-controlled commit
refactor: migrate payment module to OOP with explicit validation and session protocol
```

The second has semantic value as project history. The first is noise.

---

## Comparison with Current Flow

The current flow is **manually git-native but with human control**:

```
Agent acts → review in PyCharm → commit with semantic message.
```

This provides the advantages of git-native (reversibility, checkpoint) without the disadvantages (contaminated history, loss of message control).

---

## Conclusion

Git-native is valuable when the agent works autonomously for long periods without human supervision. In a workflow with active supervision and clear milestones, it adds noise without adding real protection.

**The triad of PyCharm + Claude Code + Gemini CLI + Codex CLI with manual commits per milestone is equivalent to git-native with quality control.**

### Milestone Rule
To avoid data loss in long sessions, follow this rule:
> **Commit at the end of each milestone (Infrastructure or Execution), not just at the end of the full session.**
