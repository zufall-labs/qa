#!/usr/bin/env bash

git config core.hooksPath qa/hooks

chmod +x ./qa/hooks/*

echo "Git hooks installed successfully!"