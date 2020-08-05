#!/usr/bin/env bash
set -e

log() {
  echo "[$1] $2"
}

log_section(){
  log "    SECTION    " "$1"
}

log_install() {
  log "INSTALLING" "$1:"
}

log_config() {
  log "CONFIGURATION" "$1:"
}

log_interactive(){
  log "INTERACTIVE" "$1:"
  read -n 1 -s -r -p "press any key to continue..."
}

log_success() {
  log "SUCCESS" "$1"
}






export GPG_TTY=$(tty)
GLOBAL_OP_EXEC="$HOME/voidrice/.local/bin/op"
DIR=$(dirname $0)

prepare_fs() {
  # DIR for source based tools, such as onedrive:
  mkdir -p $HOME/src
}

install_from_gist() {
  local dir=$(mktemp -d)
  git clone git@gist.github.com:bf0478724691d8ee4ae935f47b5354db.git $dir
  sed -e '/^$/q' "$dir/remo-x1.pacmanity" | sudo pacman -S -
  yay -S $(sed -e '/^$/d' "$dir/remo-x1.pacmanity" | tr '\n' ' ')
}


register_ssh_key() { # $1: 1password document ID, $2: key name
  # download doc from 1password and save it with perm 0600 in .ssh:
  mkdir -p "$HOME/.ssh"
  local KEY_PATH="$HOME/.ssh/$2"
  log_config "registering SSH key $KEY_PATH"
  $GLOBAL_OP_EXEC get document "$1" > $KEY_PATH
  chmod 0600 $KEY_PATH

  # get the password saved in the same doc and generate the public part of the key:
  local KEY_PW=$($GLOBAL_OP_EXEC get item "$1" | jq -r '.details.sections[0].fields[] | select(.t | contains("Password")).v')
  ssh-keygen -y -P "$KEY_PW" -f $KEY_PATH > "$KEY_PATH.pub"
}

register_gpg_key() { # $1: 1password document ID, $2: key name
  log_config "registering GPG key $2"

  # get the password saved in the same doc
  local KEY_PW=$($GLOBAL_OP_EXEC get item "$1" | jq -r '.details.sections[0].fields[] | select(.t | contains("Password")).v')
  $GLOBAL_OP_EXEC get document "$1" | gpg --import --passphrase="$KEY_PW"
}

installDrivers() {
  log_section "DRIVERS"

  log_install "graphics/Nvidia"
  sudo pacman -S nvidia nvidia-settings
  log_config "using nvidia-xconfig to update Xorg config for Nvidia"
  nvidia-xconfig

  log_install "audio/Pulseaudio"
  sudo pacman -S pulseeffects alsa-utils
  log_config "loading noice-cancelling module"
  sudo echo "load-module module-echo-cancel" >> /etc/pulse/default.pa
}

setup1password() {
  log_interactive "Trying to sign in to 1password. Keep all credentials ready."
  local addr email master
  read -p "sign-in address: " addr
  read -p "e-mail address: " email
  read -p "master key: " master
  eval $($GLOBAL_OP_EXEC signin $addr $email $master)
}


signinTo1password() {
  eval $($GLOBAL_OP_EXEC signin my)
}

registerGpgSshKeys() {
  signinTo1password
  log_section "REGISTERING GPG/SSH KEYS"

  register_gpg_key l3gdeddn5jk3odpwv2555a3y6q remolueoend@users.noreply.github.com

  log_config "downloading and registering SSH key id_gitlab"
  register_ssh_key "4lptcypbxkvqftw3wj5qci7lvi" "id_gitlab"
  log_config "downloading and registering SSH key id_rmo"
  register_ssh_key "qhysgcxdtjcvzrsjfdxxfsmcoe" "id_rmo"
  log_config "downloading and registering SSH key id_github"
  register_ssh_key "ftihxdupswsmgz6tkzdbrspeba" "id_github"
}

manualInstallations() {
  log_section "MANUAL INSTALLATIONS"

  # GVM/GOLANG: we ignore any release and beta tagged versions:
  LASTEST_GO_VERSION=$(gvm listall | awk '/go[0-9\.]{1,7}$/ {print}' | tail -n 1 | xargs)
  log_install "Golang version $LASTEST_GO_VERSION using GVM"
  gvm install $LASTEST_GO_VERSION && gvm use $LASTEST_GO_VERSION

  log_install "Rust Language"
  rustup toolchain install stable
  rustup default stable

  log_config "initializing NVM"
  export NVM_DIR="$HOME/.nvm"
  export NVM_SOURCE="/usr/share/nvm"
  source "$NVM_SOURCE/nvm.sh"
  source "$NVM_SOURCE/init-nvm.sh"

  local LATEST_NODE_VERSION=$(nvm ls-remote | awk '/v[0-9\.]{5,8}/ {print}' | tail -n 1 | xargs)

  log_install "Node.js version $LATEST_NODE_VERSION using NVM"
  log_config "activating $LATEST_NODE_VERSION (only for this script)"
  nvm use $LATEST_NODE_VERSION

  log_install "Python 3.7.4 using pyenv"
  pyenv install 3.7.4

  log_install "prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  log_install "custom prezto theme"
  npm install -g https://github.com/remolueoend/remolueoend.zsh-theme.git

  log_install "Spacemacs"
  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

  log_install "OneDrive"
  git clone https://github.com/skilion/onedrive.git $HOME/src/onedrive
  pushd %HOME/src/onedrive
  make
  sudo make install
  popd

  log_install "rhysd/dotfiles"
  go get -v github.com/rhysd/dotfiles
}

configureUserTools() {
  log_section "CONFIGURING USER TOOLS"

  log_config "activating ZSH as default shell"
  chsh -s /usr/bin/zsh

  log_config "registering this setup as Arch distro"
  echo "DOTFILES_OS=Arch" > "$HOME/.dot-files.env"


  log_config "registering pass autocompletion files"
  mkdir -p $HOME/.zfunc
  (cd $HOME/.zfunc && curl -o _pass https://git.zx2c4.com/password-store/plain/src/completion/pass.zsh-completion)


  #log_config "Setting up OneDrive. Ready?"
  #onedrive
  #systemd --user enable onedrive

  log_config "setting up codecs for vivaldi"
  curl https://launchpadlibrarian.net/424938057/chromium-codecs-ffmpeg-extra_74.0.3729.169-0ubuntu0.16.04.1_amd64.deb | tail -c+1077 | tar JxC ~ --wildcards \*libffmpeg.so --xform 's,.*/,.local/lib/vivaldi/,'

  log_config "ExpressVPN"
  systemctl start expressvpn.service
  log_interactive "get ExpressVPN activation code from: https://www.expressvpn.com/subscriptions and paste it in the next prompt."
  expressvpn activate
  systemctl stop expressvpn.service
}

linkDotFiles() {
  log_section "LINK DOTFILES"

  log_config "linking dotfiles from $HOME/voidrice to $HOME"
  (cd $HOME/voidrice && dotfiles link)
}

# checkout:
# https://github.com/DerekTBrown/pacmanity

prepare_fs
install_from_gist
installDrivers
manualInstallations
setup1password
registerGpgSshKeys
configureUserTools
linkDotFiles

# updates:
# make sure to enable all required services (lightdm, etc)
# disable unwanted services (teamviewer, vpn, etc)
# sync ssh/gpg keys
# 
