#!/usr/bin/env bash

case "$OSTYPE" in
  darwin*)  bin_path="$HOME/.local/ricebin-macos" ;;
  linux*)   bin_path="$HOME/.local/ricebin" ;;
  *)        echo "unknown OSTYPE in ~/.local/ricebin-shared/shared.sh: $OSTYPE"; exit 1 ;;
esac

run_shared_command() {
  exec "$bin_path/$1" "${@:2}"
}
