ESH_VERSION=0.0.0
ESH_CLEAR="\033[0m"
ESH_COLOR_GREEN="\033[32;m"

function esh_version {
    echo $ESH_VERSION
}

function esh_print_info {
    local message=$1
    echo -e "[${ESH_COLOR_GREEN}INFO${ESH_CLEAR}] ${message}"
}
