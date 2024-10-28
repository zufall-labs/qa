#!/usr/bin/env bash

set -e

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: not in a git repository" >&2
    exit 1
fi

git config core.hooksPath qa/hooks
git config core.fileMode false

if [ -d "qa/.git" ] || [ -f "qa/.git" ]; then  # handles both regular and submodule .git
    (cd qa && git config core.fileMode false)
fi

chmod +x ./qa/hooks/*

if command -v tput > /dev/null 2>&1; then
    echo "$(tput bold)$(tput setaf 2)✓ Git hooks installed successfully!$(tput sgr0)"
else
    echo -e "\033[1;32m✓ Git hooks installed successfully!\033[0m"
fi