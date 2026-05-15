#!/bin/zsh

set -e

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

echo "ZenClaw Dashboard HTML"
echo "Project: $PROJECT_DIR"
echo ""

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: this folder is not a Git repository."
  echo "Press any key to close..."
  read -k 1
  exit 1
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "Error: Git remote 'origin' is not set."
  echo "Press any key to close..."
  read -k 1
  exit 1
fi

echo "Checking changes..."
if [[ -z "$(git status --porcelain)" ]]; then
  echo "No changes to push."
  echo ""
  echo "Press any key to close..."
  read -k 1
  exit 0
fi

echo ""
git status --short
echo ""

echo "Enter commit message, then press Return."
echo "Leave blank to use: Update UI"
read "COMMIT_MESSAGE?> "

if [[ -z "$COMMIT_MESSAGE" ]]; then
  COMMIT_MESSAGE="Update UI"
fi

echo ""
echo "Adding files..."
git add .

echo "Creating commit..."
git commit -m "$COMMIT_MESSAGE"

echo "Pushing to GitHub..."
git push

echo ""
echo "Done. GitHub Pages will update shortly:"
echo "https://hedywu-web.github.io/zenclaw-dashboard-html/"
echo ""
echo "Press any key to close..."
read -k 1
