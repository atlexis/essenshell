[[ -n "${_ESH_PRINT_LOADED-}" ]] && return
_ESH_PRINT_LOADED=true

ESH_CLEAR="\033[0m"
ESH_BOLD="\033[1m"

ESH_BLACK="\033[30m"
ESH_RED="\033[31m"
ESH_GREEN="\033[32m"
ESH_YELLOW="\033[33m"
ESH_BLUE="\033[34m"
ESH_MAGENTA="\033[35m"
ESH_CYAN="\033[36m"
ESH_WHITE="\033[37m"
ESH_BRIGHT_BLACK="\033[90m"
ESH_BRIGHT_RED="\033[91m"
ESH_BRIGHT_GREEN="\033[92m"
ESH_BRIGHT_YELLOW="\033[93m"
ESH_BRIGHT_BLUE="\033[94m"
ESH_BRIGHT_MAGENTA="\033[95m"
ESH_BRIGHT_CYAN="\033[96m"
ESH_BRIGHT_WHITE="\033[97m"

ESH_BOLD_BLACK="\033[1;30m"
ESH_BOLD_RED="\033[1;31m"
ESH_BOLD_GREEN="\033[1;32m"
ESH_BOLD_YELLOW="\033[1;33m"
ESH_BOLD_BLUE="\033[1;34m"
ESH_BOLD_MAGENTA="\033[1;35m"
ESH_BOLD_CYAN="\033[1;36m"
ESH_BOLD_WHITE="\033[1;37m"
ESH_BOLD_BRIGHT_BLACK="\033[1;90m"
ESH_BOLD_BRIGHT_RED="\033[1;91m"
ESH_BOLD_BRIGHT_GREEN="\033[1;92m"
ESH_BOLD_BRIGHT_YELLOW="\033[1;93m"
ESH_BOLD_BRIGHT_BLUE="\033[1;94m"
ESH_BOLD_BRIGHT_MAGENTA="\033[1;95m"
ESH_BOLD_BRIGHT_CYAN="\033[1;96m"
ESH_BOLD_BRIGHT_WHITE="\033[1;97m"

[ -z ${ESH_DEBUG+x} ] && ESH_DEBUG=false

_ESH_APP_NAME=""
_ESH_APP_COLOR=""

function _esh_print_prompt {
    local color=$1
    local prompt=$2
    local message=$3

    if [ -z "$_ESH_APP_NAME" ]; then
        echo -e "[${color}${prompt}${ESH_CLEAR}] ${message}"
    elif [ -z "$_ESH_APP_COLOR" ]; then
        echo -e "[${_ESH_APP_NAME}:${color}${prompt}${ESH_CLEAR}] ${message}"
    else
        echo -e "[${_ESH_APP_COLOR}${_ESH_APP_NAME}${ESH_CLEAR}:${color}${prompt}${ESH_CLEAR}] ${message}"
    fi
}

function esh_print_info {
    local message=$1
    _esh_print_prompt "$ESH_BOLD_BRIGHT_GREEN" "INFO" "$message"
}

function esh_print_warning {
    local message=$1
    _esh_print_prompt "$ESH_BOLD_BRIGHT_YELLOW" "WARNING" "$message"
}

function esh_print_error {
    local message=$1
    _esh_print_prompt "$ESH_BOLD_BRIGHT_RED" "ERROR" "$message"
}

function esh_print_debug {
    $ESH_DEBUG || return

    local message=$1
    _esh_print_prompt "$ESH_BOLD_BRIGHT_MAGENTA" "DEBUG" "$message"
}

function esh_set_app_name {
    if [ -z ${1+x} ]; then
        _ESH_APP_NAME=""
    else
        _ESH_APP_NAME=$1
    fi
}

function esh_set_app_color {
    local color=$1

    case "$color" in
        "$ESH_BLACK"|\
        "$ESH_RED"|\
        "$ESH_GREEN"|\
        "$ESH_YELLOW"|\
        "$ESH_BLUE"|\
        "$ESH_MAGENTA"|\
        "$ESH_CYAN"|\
        "$ESH_WHITE"|\
        "$ESH_BRIGHT_BLACK"|\
        "$ESH_BRIGHT_RED"|\
        "$ESH_BRIGHT_GREEN"|\
        "$ESH_BRIGHT_YELLOW"|\
        "$ESH_BRIGHT_BLUE"|\
        "$ESH_BRIGHT_MAGENTA"|\
        "$ESH_BRIGHT_CYAN"|\
        "$ESH_BRIGHT_WHITE"|\
        "$ESH_BOLD_BLACK"|\
        "$ESH_BOLD_RED"|\
        "$ESH_BOLD_GREEN"|\
        "$ESH_BOLD_YELLOW"|\
        "$ESH_BOLD_BLUE"|\
        "$ESH_BOLD_MAGENTA"|\
        "$ESH_BOLD_CYAN"|\
        "$ESH_BOLD_WHITE"|\
        "$ESH_BOLD_BRIGHT_BLACK"|\
        "$ESH_BOLD_BRIGHT_RED"|\
        "$ESH_BOLD_BRIGHT_GREEN"|\
        "$ESH_BOLD_BRIGHT_YELLOW"|\
        "$ESH_BOLD_BRIGHT_BLUE"|\
        "$ESH_BOLD_BRIGHT_MAGENTA"|\
        "$ESH_BOLD_BRIGHT_CYAN"|\
        "$ESH_BOLD_BRIGHT_WHITE")
            ;;
        *)
            return
            esh_print_error "Trying to set an invalid app color."
            ;;
    esac

    _ESH_APP_COLOR="$color"
}
