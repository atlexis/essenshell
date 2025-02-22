# esh_mandatory_arg() : check if positional argument is provided, otherwise exit script
# $1 : number, the position of the mandatory argument
# $2 : error message to print if mandatory argument is missing
# $3+ : optional, list of arguments to check, commonly called with: $@
# Return codes:
# - 0: argument sucessfully found
# - 1: exit code, mandatory positional variables are unspecified
# - 2: exit code, provided argument position was not a number
# - 3: exit code, requested mandatory argument was not provided
function esh_mandatory_arg () {
    if [[ $# -lt 1 ]]; then
        echo "Missing argument: argument position"
        exit 1
    fi

    if [ $# -lt 2 ]; then
        echo "Missing argument: error message"
        exit 1
    fi

    local argn="$1"
    local error_message="$2"
    shift 2

    if [[ ! "$argn" =~ ^[0-9]+$ ]]; then
        echo "Argument position must be a number: $argn"
        exit 2
    fi

    if [ $# -lt $argn ]; then
        echo "Missing argument: $error_message"
        exit 3
    fi
}
