# Zufall Labs - QA

This repository provides a set of Git hooks that enforce quality checks and best practices on commits.

## Purpose

This repository is designed to be used as a Git submodule in other projects, specifically
the [nullpunk](https://github.com/zufall-labs/nullpunkt) repository (although this is not a requirement).
When integrated, it automatically configures Git hooks for the repository to follow certain rules and checks.

## How it works

The key files in this repository are located under the `hooks/` directory.
Each script has a special name that Git knows.
A full list of them can be found there [Git Hook](https://git-scm.com/book/ms/v2/Customizing-Git-Git-Hooks).

The [setup-hooks](scripts/setup-hooks) script configures Git to use the hooks from this directory,
ensuring that any action made within the repository is checked according to the rules.
The script also configures Git to look for hooks in the `qa/hooks/` directory instead of the default `.git/hooks/`.
This depends on the value of the `qa_config_dir` variable at the start of the [setup-hooks](scripts/setup-hooks) script.
The scripts are also made executable, so that Git can actually work with them.
Git triggers each hook automatically, depending on the performed action.

## Customizing the workflow

The hooks in this repository are modular, so they can be easily extended as needed for other Git actions, like
pre-commit, post-commit, pre-push, etc. The scripts in the `hooks/` directory can be added/modified, and they will
automatically be used by Git during the corresponding Git action.

## Overview

This setup results in roughly this architecture:

- The [setup-hooks](scripts/setup-hooks) script configures Git and the hooks
- The `hooks/` directory contains scripts that Git automatically executes, depending on the performed action, and the
  name of the script
- Each script in the `hooks/` directory contains logic specific to the action the file name correlates to
- The other scripts under the `utils/` directory contain separated and self-contained logic that can be reused where
  needed

## Working with this repository

As this repository is intended to be used as a submodule, it needs to be updated in all other repositories that use this
repository.

## Contribution

See [contributing](https://github.com/zufall-labs/.github/blob/main/CONTRIBUTING.md)
As for naming things, we are following Google's
conventions [document](https://google.github.io/styleguide/shellguide.html#s7-naming-conventions).
