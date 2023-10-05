ESH_VERSION="0.0.0"
ESH_CLEAR="\033[0m"
ESH_COLOR_BLACK="\033[30;m"
ESH_COLOR_RED="\033[31;m"
ESH_COLOR_GREEN="\033[32;m"
ESH_COLOR_YELLOW="\033[33;m"
ESH_COLOR_BLUE="\033[34;m"
ESH_COLOR_MAGENTA="\033[35;m"
ESH_COLOR_CYAN="\033[36;m"
ESH_COLOR_WHITE="\033[37;m"

[ -z ${ESH_DEBUG+x} ] && ESH_DEBUG=false

_ESH_APP_NAME=""
_ESH_APP_COLOR=""

function esh_version {
    echo "$ESH_VERSION"
}

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
    if [ -z ${1+x} ]; then
        _ESH_APP_NAME=""
    else
        _ESH_APP_NAME=$1
    fi
}

function esh_set_app_color {
    local color=$1

    case "$color" in
        "$ESH_COLOR_BLACK")
            ;;
        "$ESH_COLOR_RED")
            ;;
        "$ESH_COLOR_GREEN")
            ;;
        "$ESH_COLOR_YELLOW")
            ;;
        "$ESH_COLOR_BLUE")
            ;;
        "$ESH_COLOR_MAGENTA")
            ;;
        "$ESH_COLOR_CYAN")
            ;;
        "$ESH_COLOR_WHITE")
            ;;
        *)
            return
            ;;
    esac

    _ESH_APP_COLOR="$color"
}
