#
# Executes commands at the start of an interactive session.
#
# Authors:
#   remolueoend
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Reset PATH variable so that this file can be sourced multiple times
# without extending the PATH variable each time:
#path=(
#  /usr/local/{bin,sbin}
#  $(getconf PATH)
#)

# Register additional zsh function folder
ZFUNC_FOLDER="$HOME/.zfunc"
mkdir -p $ZFUNC_FOLDER
fpath=( $ZFUNC_FOLDER "${fpath[@]}" )

# Get current OS and try to source OS specific files
if [[ -s "$HOME/.dot-files.env" ]]; then
  source "$HOME/.dot-files.env"
  source "$HOME/dot-files/$DOTFILES_OS/.zshrc"
else
  echo "[WARN] no .dot-files.env found in home directory. OS specific envs won't be sourced."
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## PATH extensions
# HOMEDIR binaries:
export PATH=$HOME/dot-files/bin:$PATH
# default node version:
export PATH=$HOME/.nvm/versions/node/v8.11.1/bin:$PATH

# function creating a new temporary jupyter notebook
function trashbook {
    (cd ~/dev/trash/notebooks && source .env/bin/activate && jupyter-lab && deactivate)
}

function use_node {
    export NVM_DIR="$HOME/.nvm"
    export NVM_SOURCE="/usr/share/nvm"
    source "$NVM_SOURCE/nvm.sh"
    source "$NVM_SOURCE/init-nvm.sh"

    local VERSION=${1:-v8.11.1}

    nvm use $VERSION
}
function use_go {
    source "$HOME/.gvm/scripts/gvm"
    gvm use go1.12.7
}
function use_python {
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    local VERSION=${1:-3.5.6}
    pyenv shell $VERSION && echo "Now using $(python --version)"
}

function eth_mount {
    # $1: path of the drive, starting with `//`.
    # $2: target directory (must exist)
    # $3: ETH username
    sudo mount $1 $2 -o username=$3
}

# completion files:
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# use Emacs keybindings because VI bindings don't behave well with nvim:terminal
bindkey -e

# ZSH options
unsetopt correct

# source plugin manager and its plugins:
local zplugin_entry="/usr/share/zsh/plugin-managers/zplugin/zplugin.zsh"
if [ -f $zplugin_entry ]; then
    source $zplugin_entry
    zplugin light zsh-users/zsh-autosuggestions; ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#aaaaaa"
    zplugin light Valiev/almostontop
else
    echo "[zshrc:warning]: expected zplugin to be installed at $zplugin_entry"
fi

# hooks
eval "$(direnv hook zsh)"

# PERL stuff
PATH="/home/remo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/remo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/remo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/remo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/remo/perl5"; export PERL_MM_OPT;
