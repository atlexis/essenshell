[[ -n "${_ESH_MISC_LOADED-}" ]] && return
_ESH_MISC_LOADED=true

source "$ESSENSHELL_PATH/print.sh"

ESSENSHELL_VERSION="0.1.0"

function esh_version {
    echo "$ESSENSHELL_VERSION"
}

# esh_check_number : check if input is a number
#
# Only allows characters 0-9, i.e. 5.5, -5, and +7 are not considered numbers.
#
# $1 : string, the input to check whether it is a number
#
# Return codes:
# - 0: input was a number
# - 1: input was not a number
# - 93: exit code, requested mandatory argument was not provided
function esh_check_number {
    if [[ $# -lt 1 ]]; then
        esh_print_error "Missing argument ${ESH_BOLD_BRIGHT_WHITE}#1${ESH_CLEAR}: ${ESH_BOLD_BRIGHT_WHITE}input to check${ESH_CLEAR}"
        exit 93
    fi

    local _esh_cn_argn="$1"

    if [[ ! "$_esh_cn_argn" =~ ^[0-9]+$ ]]; then
        esh_print_debug "Not a number: ${ESH_BOLD_BRIGHT_WHITE}$_esh_cn_argn${ESH_CLEAR}"
        return 1
    fi
}

# esh_assert_number : assert that input is a number, otherwise exit script
#
# Only allows characters 0-9, i.e. 5.5, -5, and +7 are not considered numbers.
#
# $1 : number, the input to assert whether it is a number
#
# Return codes:
# - 0: input was a number
# - 93: exit code, requested mandatory argument was not provided
# - 93: exit code, provided input was not a number
function esh_assert_number {
    if [[ $# -lt 1 ]]; then
        esh_print_error "Missing argument ${ESH_BOLD_BRIGHT_WHITE}#1${ESH_CLEAR}: ${ESH_BOLD_BRIGHT_WHITE}input to assert${ESH_CLEAR}"
        exit 93
    fi

    local _esh_an_argn="$1"

    if [[ ! "$_esh_an_argn" =~ ^[0-9]+$ ]]; then
        esh_print_error "Not a number: ${ESH_BOLD_BRIGHT_WHITE}$_esh_an_argn${ESH_CLEAR}"
        exit 93
    fi
}
