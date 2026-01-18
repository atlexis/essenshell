# `input.sh` documentation

- Included with `source "$ESSENSHELL_PATH/input.sh"`

## Functions
- [`esh_confirm_before_action`](#esh_confirm_before_action) - Ask for user confirmation before performing an action

### `esh_confirm_before_action`
- Syntax: `esh_confirm_before_action <PROMPT> <MESSAGE> <ACTION> [<ARG>...]`
- Ask for user confirmation before performing an action.
- Ask for user input and execute the provided function if confirmed.
- Otherwise, print a provided message.
- Will append "y/N: " to the end of the prompt.
- Confirmation values: 'y', 'Y', 'yes', 'Yes', and 'YES'
- Decline values: 'n', 'N', 'q', 'Q', 'no', 'No', 'NO', 'quit', 'Quit', and 'QUIT'
- `$1` : string, prompt to ask before user input
- `$2` : string, message to print if user declines. An empty string will not be printed.
- `$3` : function, name of function to execute if user confirms
- `$4+` : **optional**, list of arguments to forward to executed function
- Return codes:
    - **0** : user confirmed
    - **1** : user declined
    - **2** : unknown answer after prompt
    - **3** : exit code, mandatory positional argument was not provided
