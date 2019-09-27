#!/usr/bin/env bash

### Directory setup
mkdir -p ~/.zfunc

echo "### Homebrew (https://brew.sh/index_de)"
if ! [ -x "$(command -v brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi



echo "### GIT (https://git-scm.com/book/en/v1/Getting-Started-Installing-Git)"
if ! [ -x "$(command -v git)" ]; then
  brew install git
fi



echo "### Install GVM"
if ! [ -x "$(command -v gmv)" ]; then
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi
# use go 1.9.5 as default version when setting up the system:
gvm install go1.9.5 && gvm use go1.9.5



echo "### linking dot-files"
go get -v github.com/rhysd/dotfiles
(cd ~/dot-files && dotfiles link)



echo "### Install Chrome"
brew cask install google-chrome


echo "### Install VSCode"
brew cask install visual-studio-code
brew tap caskroom/fonts
brew cask install font-fira-code


echo "### Install GPG Suite"
brew cask install gpg-suite



echo "### Install nvm"
if ! [ -x "$(command -v nvm)" ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
  source ~/.nvm/nvm.sh
fi
if ! [ -x "$(command -v node)" ]; then
  nvm install --lts
fi



echo "### Installing pyenv"
if ! [ -x "$(command -v pyenv)" ]; then
  brew install pyenv
  brew install pyenv-virtualenv
  brew install pipenv
fi


echo "### Install iTerm2"
brew cask install iterm2


echo "### Install Amethyst"
brew cask install amethyst


echo "### Install and setup zsh"
brew install --without-etcdir zsh
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh



echo "### Setup iTerm2"
# mv ~/Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.original.plist
# ln -s ~/dot-files/.iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist



echo "### Setup zprezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
npm install -g https://github.com/remolueoend/remolueoend.zsh-theme.git



echo "### Setup Amix vimrc"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime



echo "### Setup Sublime Text"
brew cask install sublime-text



echo "### Install and setup pass"
brew install pass
(cd ~/.zfunc && curl -o _pass https://git.zx2c4.com/password-store/plain/src/completion/pass.zsh-completion)



echo "### Install yarn"
brew install yarn



# obsolete, using pyenv instead
# echo "### Install python"
# brew install python
# pip3 install virtualenv



echo "Install docker"
brew cask install docker



echo "### Install pwgen"
brew install pwgen



echo "### Install tldr"
brew install tldr



echo "### Install entr"
brew install entr



echo "### Install ag"
brew install ag


echo "# Install peco"
brew install peco


echo "# Install ruby"
brew install ruby


echo "## Install doing"
# Use full qualified name, else OSX version of ruby will be used:
/usr/local/bin/gem install doing

echo "### Install Rust"
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain nightly
rustup completions zsh > ~/.zfunc/_rustup



### CLANG TOOLS
brew install gcc # suffixed with version, eg: gcc-7
brew install binutils # tools are prefixed with `g` -> objdump -> gobjdump



### GDB
brew install gdb
echo "set dis intel" >> ~/.gdbinit
echo "set startup-with-shell off" >> ~/.gdbinit
# SIP of OSX > Sierra fucks it up:
echo "GDB Codesigning has to be set up: https://gist.github.com/remolueoend/9915231b706158d7b7c247adae2605ef"



### RVM (https://rvm.io/):
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
# curl -sSL https://get.rvm.io | bash -s stable

