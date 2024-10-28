#!/usr/bin/env bash

git config core.hooksPath qa/hooks
git config core.fileMode false

chmod +x ./qa/hooks/*

echo -e "\033[1;32m✓ Git hooks installed successfully!\033[0m"