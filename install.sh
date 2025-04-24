#!/usr/bin/env bash

DEFAULT_INSTALL_DIR="$HOME/.local/opt/essenshell-0.1"

if [ -z "$ESSENSHELL_PATH" ]; then
    echo "Environment variable ESSENSHELL_PATH is not set."
    exit 1
fi

if ! [ -e "$ESSENSHELL_PATH/files.sh" ]; then
    echo "File not found: $ESSENSHELL_PATH/files.sh"
    exit 1
fi

source "$ESSENSHELL_PATH/files.sh"

if [ $# -ge 1 ]; then
    DEST_DIR="$1"
else
    DEST_DIR="$DEFAULT_INSTALL_DIR"
fi

if [ -e "$DEST_DIR" ]; then
    echo "Directory does already exist: $DEST_DIR"
    exit 1
fi

mkdir -p "$DEST_DIR"
SOURCE_DIR="$(dirname $(realpath "$0"))"

esh_copy_file essenshell.sh
esh_copy_file files.sh
esh_copy_file functions.sh
esh_copy_file print.sh
esh_copy_file variables.sh
esh_copy_file templates
