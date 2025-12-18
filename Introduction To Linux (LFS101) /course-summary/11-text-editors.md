# 11. Text Editors

## Learning Objectives

- Use common text editors: nano, vim, and graphical editors.
- Choose the right editor for the task and automate edits when possible.

## Key Concepts Explained

- **nano & gedit**: approachable editors for novices.
- **vi/vim**: modal editor with powerful text manipulation.
- **emacs**: extensible editor with a broad ecosystem.

## Commands & Examples

```bash
# Open a file in nano
nano /etc/hosts

# Quick vim usage: open and write
vim +:set
autoindent /etc/fstab
:wq
```

## Real-World Usage Scenarios

- Quick config edits with nano on remote systems.
- Complex multi-file refactoring using vim macros.

## Common Mistakes & Best Practices

- Mistake: Editing config files without making backups.
- Best practice: Use version control (git) for configuration when feasible.

## Summary

Choosing the right editor accelerates work. Learn at least one lightweight and one powerful editor (e.g., nano + vim).
