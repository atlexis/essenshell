ESH_VERSION=0.0.0
ESH_CLEAR="\033[0m"
ESH_COLOR_GREEN="\033[32;m"
ESH_COLOR_YELLOW="\033[33;m"

function esh_version {
    echo $ESH_VERSION
}

function esh_print_info {
    local message=$1
    local info_prompt="INFO"
    echo -e "[${ESH_COLOR_GREEN}${info_prompt}${ESH_CLEAR}] ${message}"
}

function esh_print_warning {
    local message=$1
    local warning_prompt="WARNING"
    echo -e "[${ESH_COLOR_YELLOW}${warning_prompt}${ESH_CLEAR}] ${message}"
}
