[[ -n "${_ESH_FUNCTIONS_LOADED-}" ]] && return
_ESH_FUNCTIONS_LOADED=true

source "$ESSENSHELL_PATH/print.sh"
source "$ESSENSHELL_PATH/variables.sh"

# esh_assert_function_exist() : assert that function exist
#
# $1 : function name
# Return code:
# - 0: function was found
# Exit code:
# - 93: function was not found
function esh_assert_function_exist() {
    func_name=""
    esh_assign_mandatory_arg 1 func_name "function to check if it exists" "$@"

    if ! declare -F "$func_name" > /dev/null; then
        esh_print_error "Function does not exist: ${ESH_BOLD_BRIGHT_WHITE}${func_name}${ESH_CLEAR}"
        exit 93
    fi
}

# esh_execution_for_each_n_args() : execute function with every chunk of provided number of arguments
#
# $1 : string, name of function to execute
# $2 : number, number of arguments to use for each invokation
# $3+ : optional, list of arguments to provide to function invokations
# Return codes:
# - 0: if all executions were successful
# Exit codes:
# - 93: function with provided name was not found
# - 93: number of arguments were not evenly divisible by provided number
function esh_execute_for_each_n_args() {
    local func_name=""
    esh_assign_mandatory_arg 1 func_name "function to execute with each argument" "$@"
    esh_assert_function_exist "$func_name"

    local num_args=""
    esh_assign_mandatory_arg 2 num_args "number of parameters per execution" "$@"

    shift 2

    esh_args_divisible_by "$num_args" "$@"

    while [ $# -ge "$num_args" ]; do
        local args=()
        for ((i = 0; i < num_args; i++)); do
            args+=("$1")
            shift
        done

        "$func_name" "${args[@]}"
    done
}

# esh_execution_for_each_arg() : execute function with every provided argument
#
# $1 : string, name of function to execute
# $2+ : optional, list of arguments to provide to function invokations
# Return codes:
# - 0: if all executions were successful
# Exit codes:
# - 93: function with provided name was not found
function esh_execute_for_each_arg() {
    local func_name="$1"
    shift
    esh_execute_for_each_n_args "$func_name" 1 "$@"
}

# esh_execution_for_each_two_args() : execute function chunk of every two provided arguments
#
# $1 : string, name of function to execute
# $2+ : optional, list of arguments to provide to function invokations
# Return codes:
# - 0: if all executions were successful
# Exit codes:
# - 93: function with provided name was not found
# - 93: number of arguments were not evenly divisible by provided number
function esh_execute_for_each_two_args() {
    local func_name="$1"
    shift
    esh_execute_for_each_n_args "$func_name" 2 "$@"
}

# esh_execution_for_each_three_args() : execute function chunk of every three provided arguments
#
# $1 : string, name of function to execute
# $2+ : optional, list of arguments to provide to function invokations
# Return codes:
# - 0: if all executions were successful
# Exit codes:
# - 93: function with provided name was not found
# - 93: number of arguments were not evenly divisible by provided number
function esh_execute_for_each_three_args() {
    local func_name="$1"
    shift
    esh_execute_for_each_n_args "$func_name" 3 "$@"
}

# esh_execution_for_each_four_args() : execute function chunk of every four provided arguments
#
# $1 : string, name of function to execute
# $2+ : optional, list of arguments to provide to function invokations
# Return codes:
# - 0: if all executions were successful
# Exit codes:
# - 93: function with provided name was not found
# - 93: number of arguments were not evenly divisible by provided number
function esh_execute_for_each_four_args() {
    local func_name="$1"
    shift
    esh_execute_for_each_n_args "$func_name" 4 "$@"
}

# esh_execution_for_each_five_args() : execute function chunk of every five provided arguments
#
# $1 : string, name of function to execute
# $2+ : optional, list of arguments to provide to function invokations
# Return codes:
# - 0: if all executions were successful
# Exit codes:
# - 93: function with provided name was not found
# - 93: number of arguments were not evenly divisible by provided number
function esh_execute_for_each_five_args() {
    local func_name="$1"
    shift
    esh_execute_for_each_n_args "$func_name" 5 "$@"
}

# esh_execution_for_each_six_args() : execute function chunk of every six provided arguments
#
# $1 : string, name of function to execute
# $2+ : optional, list of arguments to provide to function invokations
# Return codes:
# - 0: if all executions were successful
# Exit codes:
# - 93: function with provided name was not found
# - 93: number of arguments were not evenly divisible by provided number
function esh_execute_for_each_six_args() {
    local func_name="$1"
    shift
    esh_execute_for_each_n_args "$func_name" 6 "$@"
}
