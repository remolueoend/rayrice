#!/usr/bin/env bash

set -o nounset
set -o errexit

PKG_LIST_FILE="$HOME/voidrice/progs.csv"
package_names="${@:2}"

function add_pkg() {
    pkg_name="$1" 
    # first check if package is already in pkg-list. Do nothing if so:
    pkg_entry=$(mlr --csv filter '$NAME == "'"$pkg_name"'"' $PKG_LIST_FILE)
    if [[ $pkg_entry != "" ]]; then
        echo "package '${pkg_name}' is already in pkg-list."
        return
    fi
   pkg_desc=$(/usr/bin/pacman -Qeti $pkg_name  | grep 'Description' | cut -c19-)
   echo "$PKG_INSTALL_TAG,${pkg_name},${pkg_desc}" >> $PKG_LIST_FILE
   mlr -I --csv sort -f "NAME" $PKG_LIST_FILE
   echo "stored '$pkg_name' in pkg-list"
}

function remove_pkg() {
    pkg_name="$1" 
    mlr -I --csv filter '$NAME != "'"$pkg_name"'"' $PKG_LIST_FILE
    echo "removed '$pkg_name' from pkg-list"
}

function handle_install() {
    read -p "Do you want to store '$package_names' in pkg-list? [Y/n] " -n 1 -r
    echo
    if [[ ! "$REPLY" =~ ^[Nn] ]]; then
        for pkg in $package_names; do
            add_pkg "$pkg"
        done
    else
        echo "skipping pkg-list update"
    fi
}

function handle_uninstall() {
    read -p "Do you want to remove '$package_names' from pkg-list? [Y/n] " -n 1 -r
    echo
    if [[ ! "$REPLY" =~ ^[Nn] ]]; then
        for pkg in "$package_names"; do
            remove_pkg "$pkg"
        done
    else
        echo "skipping remove"
    fi
}


if [[ "$1" == "-S"* ]]; then
    handle_install
elif [[ "$1" == "-R"* ]]; then
    handle_uninstall
fi

