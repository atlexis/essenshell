# copies file recursively from $SOURCE_DIR to $DEST_DIR
# $1 : path to source file, relative from $SOURCE_DIR
# $2 (optional) : path to dest dir, relative from $DEST_DIR, will be same as $1 if not specified
function esh_copy_file () {
    if [ -z "$SOURCE_DIR" ]; then
        echo "Environment variable SOURCE_DIR must be set."
        return
    fi

    if [ -z "$DEST_DIR" ]; then
        echo "Environment variable DEST_DIR must be set."
        return
    fi

    local source_file="$SOURCE_DIR/$1"

    if ! [ -e "$source_file" ]; then
        echo "Source file not found: $source_file"
        return
    fi

    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi

    if [[ -e "$dest_file" || -h "$dest_file" ]]; then
        echo "Destination file already exist: $dest_file"
        return
    fi

    mkdir -p "$(dirname "$dest_file")"
    cp -r "$source_file" "$dest_file"
    echo "Copied $source_file -> $dest_file"
}
