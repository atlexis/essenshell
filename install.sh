#!/usr/bin/env bash

DEFAULT_INSTALL_DIR="$HOME/.local/opt/essenshell-0.1"

if [ $# -ge 1 ]; then
    install_dir="$1"
else
    install_dir="$DEFAULT_INSTALL_DIR"
fi

if [ -e "$install_dir" ]; then
    echo "Directory does already exist: $install_dir"
    exit 1
fi

mkdir -p "$install_dir"

source_dir="$(dirname $(realpath "$0"))"

cp -r "$source_dir/essenshell.sh" "$install_dir/"
echo "Copied $source_dir/essenshell.sh to $install_dir/essenshell.sh"
cp -r "$source_dir/print.sh" "$install_dir/"
echo "Copied $source_dir/print.sh to $install_dir/print.sh"
