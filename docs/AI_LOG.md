# AI Assistance Log

Use this file to track how AI tools helped. Keep it short and honest.

The source of truth is always:

1. Xcode project
2. GitHub repository
3. `/docs` folder

AI suggestions should not randomly redesign the app.

## Rules for using AI

- Ask for one small task at a time.
- Paste relevant current files before asking for code changes.
- Do not let AI rename architecture or create unrelated features.
- Test all code in Xcode before accepting it.
- Commit working changes often.
- If AI breaks something, revert with Git.

## Standard AI handoff prompt

```text
You are helping me with Foku, a native macOS SwiftUI menu bar study app with a pixel-art pet. Do not redesign the whole app. Only help with the specific task I give. Follow the existing architecture. Keep the system rule-based and deterministic. Do not add AI-controlled logic, server features, monetization, or unrelated files unless I ask. Explain what each changed file does.
```

## Log template

```md
## YYYY-MM-DD — Tool used: ChatGPT / Claude / other

### Task asked

### Useful output

### What I accepted

### What I changed manually

### What I rejected

### Files affected
```
