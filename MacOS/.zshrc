# NVM
export NVM_DIR=~/.nvm
source $NVM_DIR/nvm.sh

# QEMU
export PATH=/usr/local/opt/ncurses/bin:$PATH

# Rust Stuff:
export PATH=$PATH:$HOME/.cargo/bin

# Dotnet stuff:
export PATH=$PATH:/usr/local/share/dotnet

# Ruby (installed via Homebrew)
export PATH=/usr/local/opt/ruby/bin:$PATH

# Initialize GVM environment:
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Racket bins:
export PATH=$PATH:/Applications/Racket/bin

# Set JAVA_HOME if java is installed:
if [ -x "$(command -v java)" ]; then
  export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
fi

# Set ANDROID_SDK_ROOT if Android SDK is installed:
if [ -d "/usr/local/share/android-sdk" ]; then
  export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
fi

# Function returning the process ID of an app listening on
# the given port as first argument
# example: `zsh> procbyport 3001`
function procbyport {
    lsof -n -i4TCP:$1 | grep LISTEN
}

# Load iTerm shell integrations:
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
