#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# mise: expose shims to non-interactive shells (scripts, IDEs, `zsh -c`).
# Interactive shells get the full hook from `mise activate zsh` in .zshrc, which
# prepends the real tool paths and therefore takes precedence over these shims.
typeset -U path
path=("$HOME/.local/share/mise/shims" $path)
