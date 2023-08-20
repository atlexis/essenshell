ESH_VERSION=0.0.0
ESH_CLEAR="\033[0m"
ESH_COLOR_RED="\033[31;m"
ESH_COLOR_GREEN="\033[32;m"
ESH_COLOR_YELLOW="\033[33;m"
ESH_COLOR_MAGENTA="\033[35;m"

[ -z $ESH_DEBUG ] && ESH_DEBUG=false
[ -z $ESH_APP_NAME ] && ESH_APP_NAME=""

function esh_version {
    echo "$ESH_VERSION"
}

function _esh_print_prompt {
    local color=$1
    local prompt=$2
    local message=$3

    if [ -z "$ESH_APP_NAME" ]; then
        echo -e "[${color}${prompt}${ESH_CLEAR}] ${message}"
    else
        echo -e "[${ESH_APP_NAME}:${color}${prompt}${ESH_CLEAR}] ${message}"
    fi
}

function esh_print_info {
    local message=$1
    _esh_print_prompt "$ESH_COLOR_GREEN" "INFO" "$message"
}

function esh_print_warning {
    local message=$1
    _esh_print_prompt "$ESH_COLOR_YELLOW" "WARNING" "$message"
}

function esh_print_error {
    local message=$1
    _esh_print_prompt "$ESH_COLOR_RED" "ERROR" "$message"
}

function esh_print_debug {
    $ESH_DEBUG || return

    local message=$1
    _esh_print_prompt "$ESH_COLOR_MAGENTA" "DEBUG" "$message"
}

function esh_set_app_name {
    ESH_APP_NAME=$1
}
