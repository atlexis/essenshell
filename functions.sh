[[ -n "${_ESH_FUNCTIONS_LOADED}" ]] && return
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
