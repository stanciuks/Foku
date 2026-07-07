# Foku Setup Guide

## Local folder

The project is stored at:

/Users/augustasstancikas/Foku

## Git setup

Git was initialized with:

git init

First commit:

git add .
git commit -m "Initial Foku project structure and docs"

Git identity:

git config --global user.name "Augustas Stančikas"
git config --global user.email "augustas.stancikas@gmail.com"

Fix first commit author:

git commit --amend --reset-author --no-edit

## GitHub setup

The local repo was connected to GitHub with `origin`.

Push command:

git push -u origin main

GitHub password authentication failed because GitHub does not support normal passwords for Git operations.

Solution:

- install Homebrew
- install GitHub CLI
- run `gh auth login`
- push again

## Xcode setup

Next step:

Xcode → File → New → Project → macOS → App

Recommended settings:

- Product Name: Foku
- Interface: SwiftUI
- Language: Swift
- Storage: None
- Create Git repository: unchecked

Save inside:

/Users/augustasstancikas/Foku

## First Xcode goal

The first app should:

- run successfully
- use SwiftUI
- appear in the menu bar
- open a popover
- show a placeholder Foku pet
- show a timer

## Commit rule

After every working step:

git status
git add .
git commit -m "Clear description of what changed"
git push

Good commit examples:

- Create initial Xcode macOS app
- Add menu bar prototype
- Add basic focus timer
- Add session manager
- Add first XP calculation
