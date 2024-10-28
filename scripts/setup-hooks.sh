#!/usr/bin/env bash

git config core.hooksPath .githooks

chmod +x .githooks/*

echo "Git hooks installed successfully!"