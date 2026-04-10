import sys
import re
import os

def update_framework_sections(file_path):
    if not os.path.exists(file_path):
        return

    with open(file_path, 'r') as f:
        content = f.read()

    # Define standardized framework content
    # These could be read from framework/*.md in a more advanced version,
    # but for now, we keep the synchronized summaries.
    
    framework_data = {
        "user_profile": """The user identifies with **ADHD**, **lateral thinking**, and a **polymath** profile.

- **Cannot specify what they want before seeing it.** Specification emerges from contact with the material.
- **Bricolage / Opportunistic Programming:** Code as an instrument for thinking, not just a result.
- **Short cycles:** build → show → adjust. Read logs/evidence directly, don't wait for descriptions.
- **Treat initial code as disposable** until direction is validated.""",

        "approach": """**Centaur Model:** The Human provides direction/judgment (The Rider), the AI provides execution (The Horse).
- **Think before acting.** Read existing files before writing code.
- **Infrastructure First:** If a tool fails, fix the base code/client before continuing.
- **Observable Outputs:** Compare real logs against expected behavior.
- **No sycophancy.** Be concise and technical. User instructions always override this file.""",

        "development_principles": """1. **Minimal LLM:** Deterministic logic in code, not in prompts.
2. **Infrastructure Before Execution:** Fix the tool/client before continuing the task.
3. **Bounded Tool Payloads:** Filter and paginate; never return massive raw data.
4. **Context Consolidation:** Externalize learning to scripts, docs, or refactors at the end of each session."""
    }

    modified = False
    for section_id, new_text in framework_data.items():
        pattern = rf"(<!-- FRAMEWORK_SECTION: {section_id} -->).*?(<!-- /FRAMEWORK_SECTION -->)"
        replacement = rf"\1\n{new_text}\n\2"
        
        if re.search(pattern, content, flags=re.DOTALL):
            new_content = re.sub(pattern, replacement, content, flags=re.DOTALL)
            if new_content != content:
                content = new_content
                modified = True
        else:
            # If marker doesn't exist, we don't force it to avoid breaking project-specific CLAUDE.md
            pass

    if modified:
        with open(file_path, 'w') as f:
            f.write(content)
        print(f"    Sincronizadas secciones en {os.path.basename(file_path)}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        update_framework_sections(sys.argv[1])
