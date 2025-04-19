[[ -n "${_ESH_FILES_LOADED}" ]] && return
_ESH_FILES_LOADED=true

source "$ESSENSHELL_PATH/print.sh"

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
        esh_print_error "Environment variable ${ESH_BOLD_BRIGHT_WHITE}SOURCE_DIR${ESH_CLEAR} must be set."
        return 1
    fi

    if [ -z "$DEST_DIR" ]; then
        esh_print_error "Environment variable ${ESH_BOLD_BRIGHT_WHITE}DEST_DIR${ESH_CLEAR} must be set."
        return 1
    fi

    if [ $# -lt 1 ]; then
        esh_print_error "Missing first postitional argument: ${ESH_BOLD_BRIGHT_WHITE}path to source file.${ESH_CLEAR}"
        return 1
    fi

    local source_file="$SOURCE_DIR/$1"

    if ! [ -e "$source_file" ]; then
        esh_print_error "Source file not found: ${ESH_BOLD_BRIGHT_WHITE}$source_file${ESH_CLEAR}"
        return 2
    fi

    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi

    if [[ -e "$dest_file" || -h "$dest_file" ]]; then
        esh_print_error "Destination file already exist: ${ESH_BOLD_BRIGHT_WHITE}$dest_file${ESH_CLEAR}"
        return 3
    fi

    mkdir -p "$(dirname "$dest_file")"
    cp -r "$source_file" "$dest_file"
    esh_print_info "Copied ${ESH_BOLD_BRIGHT_WHITE}$source_file${ESH_CLEAR} >> ${ESH_BOLD_BRIGHT_WHITE}$dest_file${ESH_CLEAR}"
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
        esh_print_error "Environment variable ${ESH_BOLD_BRIGHT_WHITE}SOURCE_DIR${ESH_CLEAR} must be set."
        return 1
    fi

    if [ -z "$DEST_DIR" ]; then
        esh_print_error "Environment variable ${ESH_BOLD_BRIGHT_WHITE}DEST_DIR${ESH_CLEAR} must be set."
        return 1
    fi

    if [ $# -lt 1 ]; then
        esh_print_error "Missing first postitional argument: ${ESH_BOLD_BRIGHT_WHITE}path to source file.${ESH_CLEAR}"
        return 1
    fi

    source_file="$SOURCE_DIR/$1"

    if ! [ -e "$source_file" ]; then
        esh_print_error "Source file not found: ${ESH_BOLD_BRIGHT_WHITE}$source_file${ESH_CLEAR}"
        return 2
    fi

    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi

    if [ -e "$dest_file" ] || [ -h "$dest_file" ]; then
        esh_print_error "Destination file already exist: ${ESH_BOLD_BRIGHT_WHITE}$dest_file${ESH_CLEAR}"
        return 3
    fi

    mkdir -p "$(dirname "$dest_file")"
    ln -s "$source_file" "$dest_file"

    esh_print_info "Linked ${ESH_BOLD_BRIGHT_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_BRIGHT_WHITE}$source_file${ESH_CLEAR}"
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
        esh_print_error "Environment variable ${ESH_BOLD_BRIGHT_WHITE}DEST_DIR${ESH_CLEAR} must be set."
        return 1
    fi

    if [ $# -lt 1 ]; then
        esh_print_error "Missing first positional argument: ${ESH_BOLD_BRIGHT_WHITE}symbolic link to remove.${ESH_CLEAR}"
        return 1
    fi

    symlink_file="$DEST_DIR/$1"

    if ! [ -h "$symlink_file" ]; then
        if ! [ -e "$symlink_file" ]; then
            esh_print_error "Symbolic link to remove does not exist: ${ESH_BOLD_BRIGHT_WHITE}$symlink_file${ESH_CLEAR}"
            return 2
        else
            esh_print_error "Symbolic link to remove is not a symbolic link: ${ESH_BOLD_BRIGHT_WHITE}$symlink_file${ESH_CLEAR}"
            return 3
        fi
    fi

    target_file="$(readlink "$symlink_file")"

    # do not care if symbolic link is broken and target file does not exist, remove anyway.
    rm "$symlink_file"

    esh_print_info "Unlinking ${ESH_BOLD_BRIGHT_WHITE}$symlink_file${ESH_CLEAR} -x-> ${ESH_BOLD_BRIGHT_WHITE}$target_file${ESH_CLEAR}"
}

# esh_replace_symlink() : create or replace symbolic link from destination file to source file.
#
# Ask for confirmation before removing an existing symbolic link.
# Will skip symbolic links already pointing to the wanted source file.
#
# $SOURCE_DIR : directory to create source file path from
# $DEST_DIR : directory to create destination file path from
# $1 : path to source file, relative from $SOURCE_DIR
# $2 (optional) : path to destination file, relative from $DEST_DIR, will be same as $1 if omitted
# Return codes:
# - 0: successful symbolic link
# - 1: mandatory environmental and positional variables are unspecified
# - 2: source file does not exist
# - 3: unknown answer after prompt
function esh_replace_symlink() {
    if [ -z "$SOURCE_DIR" ]; then
        esh_print_error "Environment variable ${ESH_BOLD_WHITE}SOURCE_DIR${ESH_CLEAR} must be set."
        return 1
    fi

    if [ -z "$DEST_DIR" ]; then
        esh_print_error "Environment variable ${ESH_BOLD_WHITE}DEST_DIR${ESH_CLEAR} must be set."
        return 1
    fi

    if [ $# -lt 1 ]; then
        esh_print_error "Missing first postitional argument: ${ESH_BOLD_WHITE}path to source file${ESH_CLEAR}"
        return 1
    fi

    source_file="$SOURCE_DIR/$1"

    if ! [ -e "$source_file" ]; then
        esh_print_error "Source file not found: ${ESH_BOLD_WHITE}$source_file${ESH_CLEAR}"
        return 2
    fi

    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi

    if [ -e "$dest_file" ] || [ -h "$dest_file" ]; then
        original_source_file=$(readlink "$dest_file")
        if [[ "$original_source_file" == "$source_file" ]]; then
            esh_print_info "Wanted symbolic link already exist: ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_WHITE}$original_source_file${ESH_CLEAR}"
            return 0
        fi

        esh_print_info "A different symbolic link already exist: ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_WHITE}$original_source_file${ESH_CLEAR}"
        read -p "Do you want to replace it? y/N: " key

        if [[ -z "$key" ]]; then
            key="n"
        fi

        case "$key" in
            n|N|q|Q|no|No|NO|quit|Quit|QUIT)
                esh_print_info "Keeping old symbolic link: ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_WHITE}$original_source_file${ESH_CLEAR}"
                return 0
                ;;
            y|Y|yes|Yes|YES)
                esh_print_info "Removing old symbolic link: ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR} -x-> ${ESH_BOLD_WHITE}$original_source_file${ESH_CLEAR}"
                rm "$dest_file"
                ;;
            *)
                esh_print_error "Unknown input: ${ESH_BOLD_WHITE}'$key'${ESH_CLEAR}"
                return 3
                ;;
        esac
    fi

    mkdir -p "$(dirname "$dest_file")"
    ln -s "$source_file" "$dest_file"

    esh_print_info "Linked ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_WHITE}$source_file${ESH_CLEAR}"
}
