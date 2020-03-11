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
  source "$HOME/voidrice/$DOTFILES_OS/.zshrc"
else
  echo "[WARN] no .dot-files.env found in home directory. OS specific envs won't be sourced."
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## PATH extensions
# NPM global packages:
export PATH=$HOME/.npm/bin:$PATH
# go vars
export PATH=$HOME/go/bin:$PATH
export GOPATH=$HOME/go/src
# export GOROOT=/usr/bin
# rust binaries
export PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# dotnet
export PATH=$HOME/.dotnet/tools:$PATH
# ocaml
export PATH=$HOME/.opam/default/bin:$PATH
# haskell
export PATH=$HOME/.ghcup/bin:$PATH
# Ruby gem executables:
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

function use_python {
    # enables python version [$:3.5.6] for the current shell using pyenv
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    local VERSION=${1:-3.8.1}
    pyenv shell $VERSION && echo "Now using $(python --version)"
}

function use_ocaml {
    eval $(opam env)
}

function eth_mount {
    # $1: ETH username
    sudo mount "//d.ethz.ch/users/all/$1" $HOME/eth/home -o username=$1
}


function eth_mount_software {
    # $1 eth-username
    local mnt_point="/mnt/eth-software"
    sudo mkdir -p $mnt_point
    sudo mount //software.ethz.ch/$1$ $mnt_point -t cifs -o username=$1,vers=2.1
}

# completion files:
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# configure VI mode for ZSH:
bindkey -v
bindkey "^R" history-incremental-search-backward

# ZSH options
unsetopt correct

# manual plugins
source $HOME/src/fzf-tab/fzf-tab.plugin.zsh

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

source /home/remo/.config/broot/launcher/bash/br

alias E="SUDO_EDITOR=\"emacsclient\" sudo -e"
