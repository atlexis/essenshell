[[ -n "${_ESH_INPUT_LOADED-}" ]] && return
_ESH_INPUT_LOADED=true

source "$ESSENSHELL_PATH/files.sh"
source "$ESSENSHELL_PATH/print.sh"

# esh_confirm_before_action() : ask for user confirmation before performing an action
#
# Ask for user input and execute the provided function if confirmed.
# Otherwise, print a provided message.
# Will append "y/N: " to the end of the prompt.
# Confirmation values: 'y', 'Y', 'yes', 'Yes', and 'YES'
# Decline values: 'n', 'N', 'q', 'Q', 'no', 'No', 'NO', 'quit', 'Quit', and 'QUIT'
#
# $1 : string, prompt to ask before user input
# $2 : string, message to print if user declines. An empty string will not be printed.
# $3 : function, name of function to execute if user confirms
# $4+ : optional, list of arguments to forward to executed function
# Return codes:
# - 0: user confirmed
# - 1: user declined
# - 2: unknown answer after prompt
# Exit codes:
# - 3: mandatory positional argument was not provided
function esh_confirm_before_action() {
    esh_assign_mandatory_arg 1 prompt "prompt to ask" "$@"
    esh_assign_mandatory_arg 2 decline_message "message to print if decline" "$@"
    esh_assign_mandatory_arg 3 action "function to execute if confirmed" "$@"
    shift 3

    read -p "$prompt y/N: " key

    if [[ -z "$key" ]]; then
        key="n"
    fi
    esh_print_debug "Input: $key"

    case "$key" in
        n|N|q|Q|no|No|NO|quit|Quit|QUIT)
            if [[ "$decline_message" ]]; then
                esh_print_info "$decline_message"
            fi
            return 1
            ;;
        y|Y|yes|Yes|YES)
            "$action" "$@"
            ;;
        *)
            esh_print_warning "Unknown input: ${ESH_BOLD_WHITE}'$key'${ESH_CLEAR}"
            return 2
            ;;
    esac
}
