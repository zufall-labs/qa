#!/usr/bin/env bash

# Enable strict error handling:
# - 'set -e' causes the script to exit immediately if any command fails (non-zero exit status).
# - 'set -u' causes the script to exit if any variable is used before being set.
# - 'set -o pipefail' ensures that the script exits if any command in a pipeline fails, not just the last one.
set -euo pipefail

echo "Starting the 'setup-hooks.sh' script"

echo "Checking if 'git' is installed"
if ! command -v git > /dev/null 2>&1; then
  echo "Error: Git is required, but it is not installed." >&2
  exit 1
fi

echo "Checking if 'tput' is installed (for colored output)"
if ! command -v tput > /dev/null 2>&1; then
  echo "Warning: tput is not installed. Colored output will be disabled."
  TPUT_INSTALLED=false
else
  TPUT_INSTALLED=true
fi

echo "Checking if the current directory is a git repository"
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Error: not in a git repository" >&2
  exit 1
fi

echo "Checking if the git hooks are already configured"
# Try to get the current hooks path; The command returns an error if it is not set, therefore the redirect and the empty string.
current_hooks_path=$(git config --get-all core.hooksPath 2>/dev/null || echo "")
if [ "$current_hooks_path" == "qa/hooks" ]; then
  echo "Git hooks are already configured to use 'qa/hooks/' directory."
else
  echo "Configuring Git to use hooks from 'qa/hooks/' directory..."
  if [ ! -d "./qa/hooks" ]; then
    echo "Error: 'qa/hooks' directory does not exist. Please check your repository setup." >&2
    exit 1
  fi
  git config core.hooksPath qa/hooks
  echo "Git hooks path successfully configured."
fi

echo "Configuring Git to ignore changes to file permissions"
git config core.fileMode false
if [ -d "qa/.git" ] || [ -f "qa/.git" ]; then # handles both regular and submodule .git
  echo "Configuring Git in the 'qa' submodule to ignore changes to file permissions"
  (cd qa && git config core.fileMode false)
fi

echo "Ensuring that hook scripts are executable..."
chmod +x ./qa/hooks/* || { echo "Error: Failed to set executable permissions for hook scripts." >&2; exit 1; }

if [ "$TPUT_INSTALLED" = true ]; then
    echo "$(tput bold)$(tput setaf 2)✓ Git hooks installed successfully!$(tput sgr0)"
else
    echo -e "\033[1;32m✓ Git hooks installed successfully!\033[0m"
fi
