# Foku Setup Instructions

## 1. Install/check tools

Required:

- macOS
- Xcode
- Git
- GitHub account

Optional for later:

- Aseprite
- Figma
- Excalidraw
- VS Code

## 2. Create folder

Recommended location:

```bash
mkdir -p ~/Developer/Foku
cd ~/Developer/Foku
```

## 3. Initialize Git

```bash
git init
git add .
git commit -m "Initial Foku project docs"
```

## 4. Create Xcode project

In Xcode:

1. File → New → Project.
2. Choose macOS → App.
3. Product Name: Foku.
4. Interface: SwiftUI.
5. Language: Swift.
6. Storage: None for now.
7. Save inside `~/Developer/Foku`.

## 5. First app goal

Create a menu bar app using `MenuBarExtra` with a popover and a simple timer.

## 6. Commit often

Example commits:

```bash
git add .
git commit -m "Add menu bar app shell"
git commit -m "Add focus session timer"
git commit -m "Add basic session model"
```
