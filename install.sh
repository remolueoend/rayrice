#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOTFILES_REPO_PATH=$SCRIPT_DIR $SCRIPT_DIR/.local/ricebin/dotfiles link
