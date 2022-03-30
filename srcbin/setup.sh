#!/usr/bin/env bash

set -o nounset
set -o errexit

source_root="$HOME/srcbin"
bin_root="$source_root/bin/"
next_steps=()

CLEAN=false
if [[ $# -gt 0 && "$1" == "--clean" ]]; then
    CLEAN=true
fi

# Clones the repo at the given URL into the given path.
# The 3. argument should be the name of the package, mostly
# used for logging.
# Returns true if the repo was cloned, else false.
function __clone() {
    local git_url="$1"
    local src_dir="$2"
    local name="$3"

    if [[ "$CLEAN" = true ]]; then
        rm -rf "$src_dir"
    fi

    if [[ -d $src_dir ]]; then
        echo "[INFO] $src_dir exists"
        false
    else
        echo "[INFO] cloning $name"
        git clone "$git_url" "$src_dir"
        true
    fi
}

# installs https://github.com/Aloxaf/fzf-tab
# a zsh tab completion module based on fzf.
install_fzf_tab() {
    local src_dir="$source_root/fzf-tab"
    __clone "https://github.com/Aloxaf/fzf-tab" "$src_dir" "fzf-tab" || true
}

# installs https://github.com/dexpota/kitty-themes
# collection of kitty themes which are linked from the kitty config
install_kitty_themes() {
    local src_dir="$source_root/kitty-themes"
    __clone "https://github.com/dexpota/kitty-themes" "$src_dir" "kitty-themes" || true
}

# installs the default GNU password store
install_password_store() {
    local src_dir="$HOME/.local/share/password-store"
    if __clone "git@github.com:remolueoend/password-store.git" "$src_dir" "password-store"; then
        next_steps+=("Import the GPG key with ID EB90 ... using gpg --import <key_file_path>")
    fi
}

# installs our custom keyboard driver for remapping keys.
# Uses https://gitlab.com/interception/linux/tools for capuring and forwarding keys.
install_udevmon_layers() {
    local src_dir="$source_root/udevmon-layers"
    if __clone "git@github.com:remolueoend/udevmon-layers.git" "$src_dir" "udevmon-layers"; then
        cd "$src_dir/packages/udevmon_layers_ts"
        yarn install
        yarn build
    fi
}

# Installs our custom pretzto theme
install_prezto_theme() {
    local src_dir="$source_root/remolueoend.zsh-theme"
    if __clone "git@github.com:remolueoend/remolueoend.zsh-theme.git" "$src_dir" "remolueoend.zsh-theme"; then
        cd "$src_dir/scripts"
        ./install.sh
    fi
}

# installs https://github.com/JRGGRoberto/zplugin#installation,
# a zsh plugin system.
install_zplugin() {
    local src_dir="$source_root/zplugin"
    __clone "https://github.com/zdharma/zplugin.git" "$src_dir" "zplugin" || true
}

show_next_steps() {
    echo ""
    echo "Next steps:"
    echo "============================================"
    for step in "${next_steps[@]}"; do
        echo "- $step"
    done
}

install_fzf_tab
install_kitty_themes
install_zplugin
install_password_store
install_udevmon_layers
install_prezto_theme

show_next_steps

# installs https://github.com/fniessen/orgmk
# collection of tools for automating org-mode exports to various formats.
# install_orgmk() {
#     local src_dir="$source_root/orgmk"
#     git clone git@github.com:fniessen/orgmk.git $src_dir
#     pushd $source_root
#     echo "BIN_DIR=$bin_root" >"$src_dir/Make.params"
#     make
#     make install
#     popd
# }

# # installs https://github.com/lldb-tools/lldb-mi
# # lldb's machine interface used (at least) by the C/C++ spacemacs layer.
# install_lldb_mi() {
#     local src_dir="$source_root/lldb-mi"
#     git clone git@github.com:lldb-tools/lldb-mi.git $src_dir
#     pushd $source_root
#     cmake -DCMAKE_INSTALL_PREFIX="$bin_root" .
#     cmake --build .
#     popd
# }
