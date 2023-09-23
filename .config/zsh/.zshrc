# Luke's config for the Zoomer Shell

function is_installed {
    type "$1" >/dev/null
}

ZFUNC_FOLDER="$HOME/.zfunc"
mkdir -p $ZFUNC_FOLDER
fpath=($ZFUNC_FOLDER "${fpath[@]}")

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export DOTFILES_ROOT="$HOME/rayrice"

## PATH extensions
# NPM/yarn global packages:
export PATH=$HOME/.npm/bin:$HOME/.yarn/bin:$PATH
# rust binaries
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/cargo/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# dotnet
if is_installed "dotnet"; then
    export PATH=$HOME/.dotnet/tools:$PATH
fi

# ocaml
if is_installed "opam"; then
    export PATH=$HOME/.opam/default/bin:$PATH
fi

# haskell
if is_installed "ghcup"; then
    export GHCUP_USE_XDG_DIRS=1 # use XDG dirs, see: https://gitlab.haskell.org/haskell/ghcup-hs/#xdg-support
    export PATH=$HOME/.cabal/bin:$PATH
fi

# Ruby gem executables:
if is_installed "ruby"; then
    export PATH=$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH
fi

# Go
if is_installed "go"; then
    export PATH=$PATH:$GOPATH/bin:$GOPATH/src/github.com/docker/docker-credential-helpers/bin
    # custom built executables:
    export PATH=$SRCBIN_DIR/build:$PATH
fi

# snap on linux
if is_installed "snap"; then
    # binaries installed via snap:
    export PATH=/var/lib/snapd/snap/bin:$PATH
fi

# latex (mactex) on macos via brew:
if [ -d /Library/TeX/texbin ]; then
    export PATH=$PATH:/Library/TeX/texbin
fi

function killport {
    # kill the process listening on the given port
    # $1: port on which the process is listening on
    sudo kill $(lsof -t -i:$1)
}

function use_pyenv {
    # enables python version [$:3.8.1] for the current shell using pyenv
    eval "$(pyenv init -)"
}

function use_nvm() {
    NVM_DIR="$HOME/.nvm"
    # load NVM in the current shell, pretty slow
    [ -e "/usr/share/nvm/init-nvm.sh" ] && \. "/usr/share/nvm/init-nvm.sh"
    [ -e "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
}

function use_ocaml {
    eval $(opam env)
}

function eth_mount {
    # Mounts the ETH user shared drive to ~/eth_home
    # $1: ETH username
    sudo mount "//d.ethz.ch/users/all/$1" $HOME/eth_home -o username=$1
}

function eth_mount_software {
    # Mounts the ETH software drive to /mnt/eth-software
    # $1 eth-username
    local mnt_point="/mnt/eth-software"
    sudo mkdir -p $mnt_point
    sudo mount //software.ethz.ch/$1$ $mnt_point -t cifs -o username=$1,vers=2.1
}

function mkd {
    # creates a folder (and its parents) and navigates to it
    # $1: relative or absolute path to folder
    mkdir -pv $1
    cd $1
}

reboot_to_windows() {
    # requires to set GRUB_DEFAULT=saved in /etc/default/grub and then grub-mkconfig -o /boot/grub/grub.cfg
    # if windows entry is missing in /boot/grub/grub.cfg, follow the instructions (mount windows or EFI partition) at
    # https://wiki.archlinux.org/title/GRUB#Configuration, chapter 'detecting other operating systems'
    windows_title=$(sudo grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$windows_title" && sudo reboot
}
alias reboot-to-windows='reboot_to_windows'

# Enable colors and change prompt:
autoload -U colors && colors # Load colors
setopt autocd                # Automatically cd into typed directory.
stty stop undef              # Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History settings:
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Custom completions for some scrips:
if is_installed "pacman"; then
    compdef pacman-pkg-install='pacman'
    compdef p='pacman'
    setopt complete_aliases
    compdef yay-pkg-install='yay'
    setopt complete_aliases
fi


# vi mode
bindkey -v
# default history handler:
bindkey "^R" history-incremental-search-backward
#unsetopt correct

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey -s '^o' 'rangercd\n'
bindkey -s '^a' 'bc -lq\n'
bindkey '^[[P' delete-char
bindkey '^e' edit-command-line
bindkey "^F" forward-word
# bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/config ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/config

rangercd() {
    # Use ranger to switch directories and bind it to ctrl-o
    # When starting ranger, <Enter> is mapped to writing the selected
    # directory to a temp file, quitting ranger and then navigating to it in the current shell.
    tmp="$(mktemp)"
    ranger \
        --show-only-dirs \
        --cmd="map <Enter> chain shell echo %d > \"$tmp\"; quit"

    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}


# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line

# manual plugins
export KEYTIMEOUT=1

# source plugins
source $SRCBIN_DIR/fzf-tab/fzf-tab.plugin.zsh
source $SRCBIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
# plugin settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#aaaaaa"

# hooks
if is_installed "direnv"; then
    eval "$(direnv hook zsh)"
fi

# manages a single instance of ssh-agent.
# we could also let it register keys by itself,
# but we want to do it manually using `ssh-add`
# using passwords provided by 1password
# eval $(keychain --eval --quiet --noask id_github id_gitlab)
if is_installed "gnome-keyring-daemon"; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# PERL stuff
if is_installed "perl"; then
    PATH="$HOME/perl5/bin${PATH:+:${PATH}}"
    export PATH
    PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
    export PERL5LIB
    PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
    export PERL_LOCAL_LIB_ROOT
    PERL_MB_OPT="--install_base \"$HOME/perl5\""
    export PERL_MB_OPT
    PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
    export PERL_MM_OPT
fi

# activate python by default:
use_pyenv

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# disable cursor highlighting to avoid issues with alacritty:
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line root)

test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"

