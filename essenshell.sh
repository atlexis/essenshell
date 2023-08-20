ESH_VERSION=0.0.0
ESH_CLEAR="\033[0m"
ESH_COLOR_RED="\033[31;m"
ESH_COLOR_GREEN="\033[32;m"
ESH_COLOR_YELLOW="\033[33;m"

function esh_version {
    echo $ESH_VERSION
}

function _esh_print_prompt {
    local color=$1
    local prompt=$2
    local message=$3
    echo -e "[${color}${prompt}${ESH_CLEAR}] ${message}"
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
