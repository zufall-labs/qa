#!/usr/bin/env bash

git config core.hooksPath qa/hooks

chmod +x ../hooks/*

echo "Git hooks installed successfully!"