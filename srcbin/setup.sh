#!/usr/bin/env sh

source_root="$HOME/srcbin"
bin_root="$source_root/bin/"

# installs https://github.com/Aloxaf/fzf-tab
# a zsh tab completion module based on fzf.
install_fzf_tab() {
    local src_dir="$source_root/fzf-tab"
    git clone https://github.com/Aloxaf/fzf-tab $src_dir
}

# installs https://github.com/dexpota/kitty-themes
# collection of kitty themes which are linked from the kitty config
install_kitty_themes() {
    local
    src_dir="$source_root/kitty-themes"
    git clone --depth 1 https://github.com/dexpota/kitty-themes $src_dir
}

# installs https://github.com/fniessen/orgmk
# collection of tools for automating org-mode exports to various formats.
install_orgmk() {
    local src_dir="$source_root/orgmk"
    git clone git@github.com:fniessen/orgmk.git $src_dir
    pushd $source_root
    echo "BIN_DIR=$bin_root" > "$src_dir/Make.params"
    make
    make install
    popd
}

# installs https://github.com/lldb-tools/lldb-mi
# lldb's machine interface used (at least) by the C/C++ spacemacs layer.
install_lldb_mi() {
    local src_dir="$source_root/lldb-mi"
    git clone git@github.com:lldb-tools/lldb-mi.git $src_dir
    pushd $source_root
    cmake -DCMAKE_INSTALL_PREFIX="$bin_root" .
    cmake --build .
    popd
}

# installs https://github.com/JRGGRoberto/zplugin#installation,
# a zsh plugin system.
install_zplugin() {
    local src_dir="$source_root/zplugin"
    git clone https://github.com/zdharma/zplugin.git $src_dir
}

install_fzf_tab
# install_kitty_themes
install_zplugin
# install_orgmk
# install_lldb_mi

