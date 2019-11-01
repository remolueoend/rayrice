DIR=(dirname $0)

# manages a single instance of ssh-agent.
# we could also let it register keys by itself,
# but we want to do it manually using `ssh-add`
# using passwords provided by 1password
eval $(keychain --eval --quiet id_github id_gitlab)

source ~/.config/aliasrc

# Additional PATH extensions
export PATH=$HOME/src/build:$PATH
