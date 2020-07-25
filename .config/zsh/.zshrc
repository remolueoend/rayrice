# Luke's config for the Zoomer Shell

ZFUNC_FOLDER="$HOME/.zfunc"
mkdir -p $ZFUNC_FOLDER
fpath=( $ZFUNC_FOLDER "${fpath[@]}" )

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## PATH extensions
# NPM global packages:
export PATH=$HOME/.npm/bin:$PATH
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
export PATH=$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH
# Go
export PATH=$PATH:$GOPATH/bin:$GOPATH/src/github.com/docker/docker-credential-helpers/bin

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
    sudo mount "//d.ethz.ch/users/all/$1" $HOME/eth_home -o username=$1
}

function eth_mount_software {
    # $1 eth-username
    local mnt_point="/mnt/eth-software"
    sudo mkdir -p $mnt_point
    sudo mount //software.ethz.ch/$1$ $mnt_point -t cifs -o username=$1,vers=2.1
}

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward
#unsetopt correct

# manual plugins
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -l\n'

# bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# source plugins
# source $HOME/src/fzf-tab/fzf-tab.plugin.zsh

# source plugin manager and its plugins:
local zplugin_entry="/usr/share/zsh/plugin-managers/zplugin/zplugin.zsh"
if [ -f $zplugin_entry ]; then
    source $zplugin_entry
    zplugin light zsh-users/zsh-autosuggestions; ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#aaaaaa"
    bindkey "^F" forward-word
    # zplugin light Valiev/almostontop
else
    echo "[zshrc:warning]: expected zplugin to be installed at $zplugin_entry"
fi

# hooks
eval "$(direnv hook zsh)"

# manages a single instance of ssh-agent.
# we could also let it register keys by itself,
# but we want to do it manually using `ssh-add`
# using passwords provided by 1password
eval $(keychain --eval --quiet --noask id_github id_gitlab)

# PERL stuff
PATH="/home/remo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/remo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/remo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/remo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/remo/perl5"; export PERL_MM_OPT;

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
