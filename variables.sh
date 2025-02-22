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

# esh_assign_optional_arg() : assign either positional argument or default value to specified variable
# $1 : number, the position of the optional argument
# $2 : variable, name of the variable to assign resulting value to
# $3 : default value to assign to variable
# $4+ : optional, list of arguments to check, commonly called with: "$@"
# Return codes:
# - 0: variable successfully assigned
# - 1: exit code, mandatory positional variables are unspecified
# - 2: exit code, provided argument position was not a number
function esh_assign_optional_arg () {
    esh_mandatory_arg 1 "argument position" "$@"
    esh_mandatory_arg 2 "output variable" "$@"
    esh_mandatory_arg 3 "default value" "$@"

    local argn="$1"
    local output_var="$2"
    local default_value="$3"
    shift 3

    if [[ ! "$argn" =~ ^[0-9]+$ ]]; then
        echo "Argument position must be a number: $argn"
        exit 2
    fi

    if [[ $# -lt $argn ]]; then
        printf -v "$output_var" "$default_value"
    else
        args=("$@")
        printf -v "$output_var" "${args[$((argn-1))]}"
    fi
}
