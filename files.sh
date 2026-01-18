[[ -n "${_ESH_FILES_LOADED-}" ]] && return
_ESH_FILES_LOADED=true

source "$ESSENSHELL_PATH/print.sh"
source "$ESSENSHELL_PATH/variables.sh"
source "$ESSENSHELL_PATH/input.sh"

# esh_assert_file_exist() : assert that file exist
#
# Does not resolve symbolic links, but asserts that something exist at the file path.
#
# $1 : path to file
# Return code:
# - 0: file was found
# Exit code:
# - 93: file was not found
function esh_assert_file_exist() {
    local file=""
    _esh_mute_debug
    esh_assign_mandatory_arg 1 file "path to file" "$@"

    if [[ ! -e "$file" && ! -L "$file" ]]; then
        esh_print_error "File does not exist: ${ESH_BOLD_BRIGHT_WHITE}${file}${ESH_CLEAR}"
        exit 93
    fi
}

# esh_assert_file_not_exist() : assert that file does not exist
#
# Does not resolve symbolic links, but asserts that nothing exist at the file path.
#
# $1 : path to file
# Return code:
# - 0: file was not found
# Exit code:
# - 93: file was found
function esh_assert_file_not_exist() {
    local file=""
    _esh_mute_debug
    esh_assign_mandatory_arg 1 file "path to file" "$@"

    if [[ -e "$file" || -L "$file" ]]; then
        esh_print_error "File does already exist: ${ESH_BOLD_BRIGHT_WHITE}${file}${ESH_CLEAR}"
        exit 93
    fi
}

# esh_assert_regular_file_exist() : assert that provided file exist and is a regular file
#
# Will exit with an error code if the provided path is a symbolic link, not try to resolve it.
#
# $1 : path to regular file
# Return code:
# - 0: file is found and is a regular file
# Exit code:
# - 93: file was not found
# - 93: file was not a regular file
function esh_assert_regular_file_exist() {
    local regular_file=""
    _esh_mute_debug
    esh_assign_mandatory_arg 1 regular_file "path to regular file" "$@"

    # -f will try to resolve symbolic link, so check for this first
    if [ -L "$regular_file" ]; then
        esh_print_error "Not a regular file: ${ESH_BOLD_BRIGHT_WHITE}${regular_file}${ESH_CLEAR} (symbolic link)"
        exit 93
    fi

    if [ -f "$regular_file" ]; then
        return
    fi

    if [ -e "$regular_file" ]; then
        esh_print_error "Not a regular file: ${ESH_BOLD_BRIGHT_WHITE}${regular_file}${ESH_CLEAR}"
    else
        esh_print_error "File does not exist: ${ESH_BOLD_BRIGHT_WHITE}${regular_file}${ESH_CLEAR}"
    fi

    exit 93
}

# esh_assert_directory_exist() : assert that provided file exist and is a directory
#
# Will exit with an error code if the provided path is a symbolic link, not try to resolve it.
#
# $1 : path to directory
# Return code:
# - 0: file is found and is a directory
# Exit code:
# - 93: file was not found
# - 93: file was not a directory
function esh_assert_directory_exist() {
    local directory_file=""
    _esh_mute_debug
    esh_assign_mandatory_arg 1 directory_file "path to directory" "$@"

    # -f will try to resolve symbolic link, so check for this first
    if [ -L "$directory_file" ]; then
        esh_print_error "Not a directory: ${ESH_BOLD_BRIGHT_WHITE}${directory_file}${ESH_CLEAR} (symbolic link)"
        exit 93
    fi

    if [ -d "$directory_file" ]; then
        esh_print_debug "$directory_file exists and is a directory"
        return
    fi

    if [ -e "$directory_file" ]; then
        esh_print_error "Not a directory: ${ESH_BOLD_BRIGHT_WHITE}${directory_file}${ESH_CLEAR}"
    else
        esh_print_error "File does not exist: ${ESH_BOLD_BRIGHT_WHITE}${directory_file}${ESH_CLEAR}"
    fi

    exit 93
}

# esh_assert_symlink_exist() : assert that provided file exist and is a symbolic link
#
# $1 : path to symbolic link
# Return code:
# - 0: file is found and is a symbolic link
# Exit code:
# - 93: file was not found
# - 93: file was not a symbolic link
function esh_assert_symlink_exist() {
    local symlink_file=""
    _esh_mute_debug
    esh_assign_mandatory_arg 1 symlink_file "path to symbolic link" "$@"

    if [ -h "$symlink_file" ]; then
        return
    fi

    if ! [ -e "$symlink_file" ]; then
        esh_print_error "Symbolic link does not exist: ${ESH_BOLD_BRIGHT_WHITE}$symlink_file${ESH_CLEAR}"
        exit 93
    else
        esh_print_error "Not a symbolic link: ${ESH_BOLD_BRIGHT_WHITE}$symlink_file${ESH_CLEAR}"
        exit 93
    fi
}

# esh_copy_file() : copy file or directory recursively from source file to destination file
# $SOURCE_DIR : directory to create source file path from
# $DEST_DIR : directory to create destination file path from
# $1 : path to source file, relative from $SOURCE_DIR
# $2 (optional) : path to destination file, relative from $DEST_DIR, will be same as $1 if omitted
# Return codes:
# - 0: successful copy
# - 2: source file does not exist
# Exit code:
# - 3: mandatory positional argument was not provided
# - 4: exit code, mandatory environment variable was not defined
# - 93: destination file does already exist
function esh_copy_file () {
    esh_mandatory_env SOURCE_DIR
    esh_mandatory_env DEST_DIR
    esh_mandatory_arg 1 "path to source file" "$@"

    local source_file="$SOURCE_DIR/$1"

    if ! [ -e "$source_file" ]; then
        esh_print_error "Source file not found: ${ESH_BOLD_BRIGHT_WHITE}$source_file${ESH_CLEAR}"
        return 2
    fi

    local dest_file=""
    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi
    esh_assert_file_not_exist "$dest_file"

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
# Exit codes:
# - 3: mandatory positional argument was not provided
# - 4: mandatory environment variable was not defined
# - 93: source file does not exist
# - 93: destination file does already exist
function esh_symlink_file () {
    esh_mandatory_env SOURCE_DIR
    esh_mandatory_env DEST_DIR
    esh_mandatory_arg 1 "path to source file" "$@"

    local source_file="$SOURCE_DIR/$1"
    esh_assert_file_exist "$source_file"

    local dest_file=""
    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi
    esh_assert_file_not_exist "$dest_file"

    mkdir -p "$(dirname "$dest_file")"
    ln -s "$source_file" "$dest_file"

    esh_print_info "Linked ${ESH_BOLD_BRIGHT_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_BRIGHT_WHITE}$source_file${ESH_CLEAR}"
}

# esh_remove_symlink() : remove symbolic link
# $DEST_DIR : directory to create symbolic link file path from
# $1 : path to symbolic link file, relative from $DEST_DIR
# Return codes:
# - 0: successful removal of symbolic link
# Exit codes:
# - 3: mandatory positional argument was not provided
# - 4: mandatory environment variable was not defined
# - 93: file was not found
# - 93: file was not a symbolic link
function esh_remove_symlink() {
    esh_mandatory_env DEST_DIR
    esh_mandatory_arg 1 "symbolic link to remove" "$@"

    local symlink_file="$DEST_DIR/$1"
    esh_assert_symlink_exist "$symlink_file"

    local target_file="$(readlink "$symlink_file")"

    # do not care if symbolic link is broken and target file does not exist, remove anyway.
    rm "$symlink_file"

    esh_print_info "Unlinking ${ESH_BOLD_BRIGHT_WHITE}$symlink_file${ESH_CLEAR} -x-> ${ESH_BOLD_BRIGHT_WHITE}$target_file${ESH_CLEAR}"
}

function _esh_remove_old_symlink() {
    _esh_mute_debug
    esh_assign_mandatory_arg 1 dest_file "" "$@"
    _esh_mute_debug
    esh_assign_mandatory_arg 2 original_source_file "" "$@"

    esh_print_info "Removing old symbolic link: ${ESH_BOLD_WHITE}${dest_file}${ESH_CLEAR} -x-> ${ESH_BOLD_WHITE}${original_source_file}${ESH_CLEAR}"
    rm "$dest_file"
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
# - 1: user declined removing symbolic link
# - 2: unknown answer after prompt
# Exit codes:
# - 3: mandatory positional argument was not provided
# - 4: mandatory environment variable was not defined
# - 93: source file does not exist
function esh_replace_symlink() {
    esh_mandatory_env SOURCE_DIR
    esh_mandatory_env DEST_DIR
    esh_mandatory_arg 1 "path to source file" "$@"

    local source_file="$SOURCE_DIR/$1"
    esh_assert_file_exist "$source_file"

    local dest_file=""
    if [ $# -ge 2 ]; then
        dest_file="$DEST_DIR/$2"
    else
        dest_file="$DEST_DIR/$1"
    fi

    if [ -e "$dest_file" ] || [ -h "$dest_file" ]; then
        local original_source_file=$(readlink "$dest_file")
        if [[ "$original_source_file" == "$source_file" ]]; then
            esh_print_debug "Wanted symbolic link already exist: ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_WHITE}$original_source_file${ESH_CLEAR}"
            return 0
        fi

        esh_print_info "A different symbolic link already exist: ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR}"
        esh_print_info "Old link: ${ESH_BOLD_WHITE}$original_source_file${ESH_CLEAR}"
        esh_print_info "New link: ${ESH_BOLD_WHITE}$source_file${ESH_CLEAR}"
        esh_confirm_before_action "Do you want to replace it?" "Keeping old symbolic link." _esh_remove_old_symlink "$dest_file" "$original_source_file"

        if [[ "$?" != 0 ]]; then
            return "$?"
        fi
    fi

    mkdir -p "$(dirname "$dest_file")"
    ln -s "$source_file" "$dest_file"

    esh_print_info "Linked ${ESH_BOLD_WHITE}$dest_file${ESH_CLEAR} -> ${ESH_BOLD_WHITE}$source_file${ESH_CLEAR}"
}
