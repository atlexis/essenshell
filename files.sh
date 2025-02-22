# esh_copy_file() : copy file or directory recursively from source file to destination file
# $SOURCE_DIR : directory to create source file path from
# $DEST_DIR : directory to create destination file path from
# $1 : path to source file, relative from $SOURCE_DIR
# $2 (optional) : path to destination file, relative from $DEST_DIR, will be same as $1 if omitted
# Return codes:
# - 0: successful copy
# - 1: mandatory environmental and positional variables are unspecified
# - 2: source file does not exist
# - 3: destination file already exists
function esh_copy_file () {
    if [ -z "$SOURCE_DIR" ]; then
        echo "Environment variable SOURCE_DIR must be set."
        return 1
    fi

    if [ -z "$DEST_DIR" ]; then
        echo "Environment variable DEST_DIR must be set."
        return 1
    fi

    if [ $# -lt 1 ]; then
        echo "Missing first postitional argument: path to source file."
        return 1
    fi

    local source_file="$SOURCE_DIR/$1"

    if ! [ -e "$source_file" ]; then
        echo "Source file not found: $source_file"
        return 2
    fi

    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi

    if [[ -e "$dest_file" || -h "$dest_file" ]]; then
        echo "Destination file already exist: $dest_file"
        return 3
    fi

    mkdir -p "$(dirname "$dest_file")"
    cp -r "$source_file" "$dest_file"
    echo "Copied $source_file -> $dest_file"
}

# esh_symlink_file() : create symbolic link from source file to destination file
# $SOURCE_DIR : directory to create source file path from
# $DEST_DIR : directory to create destination file path from
# $1 : path to source file, relative from $SOURCE_DIR
# $2 (optional) : path to destination file, relative from $DEST_DIR, will be same as $1 if omitted
# Return codes:
# - 0: successful symbolic link
# - 1: mandatory environmental and positional variables are unspecified
# - 2: source file does not exist
# - 3: destination file already exists
function esh_symlink_file () {
    if [ -z "$SOURCE_DIR" ]; then
        echo "Environment variable SOURCE_DIR must be set."
        return 1
    fi

    if [ -z "$DEST_DIR" ]; then
        echo "Environment variable DEST_DIR must be set."
        return 1
    fi

    if [ $# -lt 1 ]; then
        echo "Missing first postitional argument: path to source file."
        return 1
    fi

    source_file="$SOURCE_DIR/$1"

    if ! [ -e "$source_file" ]; then
        echo "Source file not found: $source_file"
        return 2
    fi

    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi

    if [ -e "$dest_file" ] || [ -h "$dest_file" ]; then
        echo "Destination file already exist: $dest_file"
        return 3
    fi

    mkdir -p "$(dirname "$dest_file")"
    ln -s "$source_file" "$dest_file"

    echo "Linked $source_file --> $dest_file"
}

# esh_remove_symlink() : remove symbolic link
# $DEST_DIR : directory to create symbolic link file path from
# $1 : path to symbolic link file, relative from $DEST_DIR
# Return codes:
# - 0: successful removal of symbolic link
# - 1: mandatory environmental and positional variables are unspecified
# - 2: symbolic link to remove does not exist
# - 3: symbolic link to remove is not a symbolic link
function esh_remove_symlink() {
    if [ -z "$DEST_DIR" ]; then
        echo "Environment variable DEST_DIR must be set."
        return 1
    fi

    if [ $# -lt 1 ]; then
        echo "Missing first positional argument: symbolic link to remove."
        return 1
    fi

    symlink_file="$DEST_DIR/$1"

    if ! [ -e "$symlink_file" ]; then
        echo "Symbolic link to remove does not exist: $symlink_file"
        return 2
    fi

    if ! [ -h "$symlink_file" ]; then
        echo "Symbolic link to remove is not a symbolic link: $symlink_file"
        return 3
    fi

    target_file="$(readlink "$symlink_file")"

    # do not care if symbolic link is broken and target file does not exist, remove anyway.
    rm "$symlink_file"

    echo "Unlinking $symlink_file -x-> $target_file"
}
