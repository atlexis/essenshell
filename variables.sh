[[ -n "${_ESH_VARIABLES_LOADED-}" ]] && return
_ESH_VARIABLES_LOADED=true

source "$ESSENSHELL_PATH/print.sh"

# esh_mandatory_arg() : check if positional argument is provided, otherwise exit script
#
# $1 : number, the position of the mandatory argument
# $2 : error message to print if mandatory argument is missing
# $3+ : optional, list of arguments to check, commonly called with: $@
#
# Return codes:
# - 0: argument sucessfully found
# - 1: exit code, mandatory positional variables are unspecified
# - 2: exit code, provided argument position was not a number
# - 3: exit code, requested mandatory argument was not provided
function esh_mandatory_arg () {
    if [[ $# -lt 1 ]]; then
        esh_print_error "Missing argument ${ESH_BOLD_BRIGHT_WHITE}#1${ESH_CLEAR}: ${ESH_BOLD_BRIGHT_WHITE}argument position${ESH_CLEAR}"
        exit 1
    fi

    if [[ $# -lt 2 ]]; then
        esh_print_error "Missing argument ${ESH_BOLD_BRIGHT_WHITE}#2${ESH_CLEAR}: ${ESH_BOLD_BRIGHT_WHITE}error message${ESH_CLEAR}"
        exit 1
    fi

    local _esh_m_argn="$1"
    local _esh_m_error_message="$2"
    shift 2

    if [[ ! "$_esh_m_argn" =~ ^[0-9]+$ ]]; then
        esh_print_error "${ESH_BOLD_BRIGHT_WHITE}Argument position${ESH_CLEAR} must be a number: ${ESH_BOLD_BRIGHT_WHITE}$_esh_m_argn${ESH_CLEAR}"
        exit 2
    fi

    if [[ $# -lt $_esh_m_argn ]]; then
        esh_print_error "Missing argument ${ESH_BOLD_BRIGHT_WHITE}#$_esh_m_argn${ESH_CLEAR}: ${ESH_BOLD_BRIGHT_WHITE}$_esh_m_error_message${ESH_CLEAR}"
        exit 3
    fi
}

# esh_assign_mandatory_arg() : try to assign positional argument to provided variable, or show error and exit script
#
# Do not assign to a variable name prefixed with "_esh". Those names are reserved for internal use by 
# essenshell and might result in errors due to variable scope clashes.
#
# $1 : number, the position of the mandatory argument
# $2 : variable, name of the variable to assign resulting value to, see restrictions above
# $3 : error message to print if mandatory argument is missing
# $4+ : optional, list of arguments to check, commonly called with: "$@"
#
# Return codes:
# - 0: variable successfully assigned
# - 1: exit code, mandatory positional variables are unspecified
# - 2: exit code, provided argument position was not a number
# - 3: exit code, requested mandatory argument was not provided
function esh_assign_mandatory_arg () {
    esh_mandatory_arg 1 "argument position" "$@"
    esh_mandatory_arg 2 "output variable" "$@"
    esh_mandatory_arg 3 "error message" "$@"

    local _esh_am_argn="$1"
    local _esh_am_output_var="$2"
    local _esh_am_error_message="$3"
    shift 3

    if [[ ! "$_esh_am_argn" =~ ^[0-9]+$ ]]; then
        esh_print_error "${ESH_BOLD_BRIGHT_WHITE}Argument position${ESH_CLEAR} must be a number: ${ESH_BOLD_BRIGHT_WHITE}$_esh_am_argn${ESH_CLEAR}"
        exit 2
    fi

    if [[ $# -lt $_esh_am_argn ]]; then
        esh_print_error "Missing argument ${ESH_BOLD_BRIGHT_WHITE}#$_esh_am_argn${ESH_CLEAR}: ${ESH_BOLD_BRIGHT_WHITE}$_esh_am_error_message${ESH_CLEAR}"
        exit 3
    fi

    local _am_args=("$@")
    printf -v "$_esh_am_output_var" "${_am_args[$((_esh_am_argn-1))]}"

    esh_print_debug "Assigned value ${ESH_BOLD_BRIGHT_WHITE}${!_esh_am_output_var}${ESH_CLEAR} to variable ${ESH_BOLD_BRIGHT_WHITE}$_esh_am_output_var${ESH_CLEAR}"
    _esh_unmute_debug
}

# esh_assign_optional_arg() : assign either positional argument or default value to provided variable
#
# Do not assign to a variable name prefixed with "_esh". Those names are reserved for internal use by
# essenshell and might result in errors due to variable scope clashes.
#
# $1 : number, the position of the optional argument
# $2 : variable, name of the variable to assign resulting value to, see restrictions above
# $3 : default value to assign to variable
# $4+ : optional, list of arguments to check, commonly called with: "$@"
#
# Return codes:
# - 0: variable successfully assigned
# - 1: exit code, mandatory positional variables are unspecified
# - 2: exit code, provided argument position was not a number
function esh_assign_optional_arg () {
    local _esh_ao_argn
    _esh_mute_debug
    esh_assign_mandatory_arg 1 _esh_ao_argn "argument position" "$@"

    local _esh_ao_output_var
    _esh_mute_debug
    esh_assign_mandatory_arg 2 _esh_ao_output_var "output variable" "$@"

    local _esh_ao_default_value
    _esh_mute_debug
    esh_assign_mandatory_arg 3 _esh_ao_default_value "default value" "$@"

    shift 3

    if [[ ! "$_esh_ao_argn" =~ ^[0-9]+$ ]]; then
        esh_print_error "${ESH_BOLD_BRIGHT_WHITE}Argument position${ESH_CLEAR} must be a number: ${ESH_BOLD_BRIGHT_WHITE}$_esh_ao_argn${ESH_CLEAR}"
        exit 2
    fi

    if [[ $# -lt $_esh_ao_argn ]]; then
        printf -v "$_esh_ao_output_var" "$_esh_ao_default_value"
        esh_print_debug "Assigned default value ${ESH_BOLD_BRIGHT_WHITE}${!_esh_ao_output_var}${ESH_CLEAR} to variable ${ESH_BOLD_BRIGHT_WHITE}$_esh_ao_output_var${ESH_CLEAR}"
    else
        local _esh_am_args=("$@")
        printf -v "$_esh_ao_output_var" "${_esh_am_args[$((_esh_ao_argn-1))]}"
        esh_print_debug "Assigned value ${ESH_BOLD_BRIGHT_WHITE}${!_esh_ao_output_var}${ESH_CLEAR} to variable ${ESH_BOLD_BRIGHT_WHITE}$_esh_ao_output_var${ESH_CLEAR}"
    fi

    _esh_unmute_debug
}

# esh_mandatory_env() : check if environment variable is defined, otherwise exit script
#
# $1 : string, name of the environment variable to check
#
# Return codes:
# - 0: environment variable is set
# - 1: exit code, mandatory positional variables are unspecified
# - 4: exit code, mandatory environment variable is undefined
function esh_mandatory_env () {
    local _esh_me_env
    _esh_mute_debug
    esh_assign_mandatory_arg 1 _esh_me_env "environment variable name" "$@"

    if [ -z "${!_esh_me_env}" ]; then
        esh_print_error "Environment variable ${ESH_BOLD_BRIGHT_WHITE}${_esh_me_env}${ESH_CLEAR} must be set."
        exit 4
    fi
}

# esh_assign_mandatory_env() : try to assign environment variable to provided variable, or show error and exit script
#
# Do not assign to a variable name prefixed with "_esh". Those names are reserved for internal use by
# essenshell and might result in errors due to variable scope clashes.
#
# $1 : string, name of the environment variable to assign from
# $2 : variable, name of the variable to assign resulting value to, see restrictions above
#
# Return codes:
# - 0 : variable successfully assigned
# - 3 : exit code, requested mandatory arguments were not provided
# - 4 : exit code, mandatory environment variable is undefined
function esh_assign_mandatory_env () {
    local _esh_ame_env
    _esh_mute_debug
    esh_assign_mandatory_arg 1 _esh_ame_env "environment variable name" "$@"
    esh_mandatory_env "$_esh_ame_env"

    local _esh_ame_output_var
    _esh_mute_debug
    esh_assign_mandatory_arg 2 _esh_ame_output_var "output variable" "$@"

    printf -v "$_esh_ame_output_var" "${!_esh_ame_env}"
    esh_print_debug "Assigned value ${ESH_BOLD_BRIGHT_WHITE}${!_esh_ame_output_var}${ESH_CLEAR} to variable ${ESH_BOLD_BRIGHT_WHITE}$_esh_ame_output_var${ESH_CLEAR}"
    _esh_unmute_debug
}

# esh_assign_optional_env() : assign either environment variable or default value to provided variable
#
# Do not assign to a variable name prefixed with "_esh". Those names are reserved for internal use by
# essenshell and might result in errors due to variable scope clashes.
#
# $1 : string, name of the environment variable to assign from
# $2 : variable, name of the variable to assign resulting value to, see restrictions above
# $3 : default value to assign to variable
#
# Return codes:
# - 0 : variable successfully assigned
# - 3 : exit code, requested mandatory arguments were not provided
function esh_assign_optional_env () {
    local _esh_aoe_env
    _esh_mute_debug
    esh_assign_mandatory_arg 1 _esh_aoe_env "environment variable name" "$@"

    local _esh_aoe_output_var
    _esh_mute_debug
    esh_assign_mandatory_arg 2 _esh_aoe_output_var "output variable" "$@"

    local _esh_aoe_default_value
    _esh_mute_debug
    esh_assign_mandatory_arg 3 _esh_aoe_default_value "default value" "$@"

    if [[ -n "${!_esh_aoe_env}" ]]; then
        printf -v "$_esh_aoe_output_var" "${!_esh_aoe_env}"
        esh_print_debug "Assigned value ${ESH_BOLD_BRIGHT_WHITE}${!_esh_aoe_output_var}${ESH_CLEAR} to variable ${ESH_BOLD_BRIGHT_WHITE}$_esh_aoe_output_var${ESH_CLEAR}"
    else
        printf -v "$_esh_aoe_output_var" "$_esh_aoe_default_value"
        esh_print_debug "Assigned default value ${ESH_BOLD_BRIGHT_WHITE}${!_esh_aoe_output_var}${ESH_CLEAR} to variable ${ESH_BOLD_BRIGHT_WHITE}$_esh_aoe_output_var${ESH_CLEAR}"
    fi

    _esh_unmute_debug
}

# esh_args_divisible_by() : assert that number of arguments are evenly dividable by the divisor
#
# $1 : number, divisor to be evenly dividable by
# $2+ : optional, list of arguments to check, commonly called with: "$@"
#
# Return codes:
# - 0: number of arguments are evenly dividable by the divisor
# Exit codes:
# - 93: number of argument are not evenly dividable by the divisor
function esh_args_divisible_by () {
    local divisor=""
    _esh_mute_debug
    esh_assign_mandatory_arg 1 divisor "divisor for number of arguments" "$@"
    shift

    if (( $# % $divisor != 0 )); then
        esh_print_error "Number of elements is not divisible by $divisor: ${ESH_BOLD_BRIGHT_WHITE}$#${ESH_CLEAR}"
        exit 93
    fi
}
