# Essenshell

Essenshell is a shell library containing the most common and essential functions.

## Installation
- Run `./install.sh` to install files on the system.
- Requires `ESSENSHELL_PATH` environment variable to be set
    - `ESSENSHELL_PATH="$PWD" ./install.sh` - install with `essenshell`-files from current working directory
- Installation directory is determined in following priority order:
    1. First positional argument `./install.sh /Path/To/Install/essenshell-0.1`
    2. Default directory, `$HOME/.local/opt/essenshell-<VERSION>`: `./install.sh`

## Usage
- Environment variable `"ESSENSHELL_PATH"` must be set before anything is sourced.
    - The directory where `essenshell/` is installed on the system.
    - E.g. `ESSENSHELL_PATH="$HOME/.local/lib/essenshell"`
- Copy a [template](#templates) into a user script to get up and running quickly
- Complete library: [`essenshell.sh`](#global)
- Sub-libraries:
    - [`files.sh`](#filessh) - file-related functions
    - [`functions.sh`](#functionssh) - function-related functions
    - [`print.sh`](#printsh) - print-related functions
    - [`variables.sh`](#variablessh) - variable-related functions
- **Note**: Sourced variables and functions beginning with an underscore are private variables and are only intended for internal use, do not rely on these directly since their APIs are not stable and might change at any time.

### Templates
- Copy the content of any template file into your user script
- _Neovim_ example: `:read $ESSENSHELL_PATH/templates/verify_essenshell_path`
- `templates/verify_essenshell_path`
    - verify that `ESSENSHELL_PATH` environment variable is set
    - fallback and try default path if not, `$HOME/.local/lib/essenshell`
    - verify that `$ESSENSHELL_PATH/essenshell.sh` is available
    - source `$ESSENSHELL_PATH/essenshell.sh` into script

### Global
- Included with `source essenshell.sh`
- Variables:
    - `ESSENSHELL_VERSION` - current version of essenshell
- Functions:
- `esh_version` - print version of essenshell
- Includes:
    - [files.sh](#filessh)
    - [functions.sh](#functionssh)
    - [print.sh](#printsh)
    - [variables.sh](#variables.sh)

### files.sh
- Included with `source "$ESSENSHELL_PATH/files.sh"`

#### files.sh functions
- `esh_assert_file_exist <PATH>` : assert that file exist
    - Does not resolve symbolic links, but asserts that something exist at the file path.
    - `$1` (`<PATH>`): path to file
    - Return code:
        - **0**: file was found
    - Exit code:
        - **93**: file was not found
- `esh_assert_file_not_exist <PATH>` : assert that file does not exist
    - Does not resolve symbolic links, but asserts that nothing exist at the file path.
    - `$1` (`<PATH>`): path to file
    - Return code:
        - **0**: file was not found
    - Exit code:
        - **93**: file was found
- `esh_assert_regular_file_exist <PATH>` : assert that provided file exist and is a regular file
    - Will exit with an error code if the provided path is a symbolic link, not try to resolve it.
    - `$1` (`<PATH>`): path to regular file
    - Return code:
        - **0**: file is found and is a regular file
    - Exit code:
        - **93**: file was not found
        - **93**: file was not a regular file
- `esh_assert_symlink_exist <PATH>` : assert that provided file exist and is a symbolic link
    - `$1` (`<PATH>`): path to symbolic link
    - Return codes:
        - **0**: file is found and is a symbolic link
    - Exit codes:
        - **93**: file was not found
        - **93**: file was not a symbolic link
- `esh_copy_file <SRC> [<DEST>]` : copy file or directory recursively from source file to destination file
    - `$SOURCE_DIR` : directory to create source file path from
    - `$DEST_DIR` : directory to create destination file path form
    - `$1` (`<SRC>`) - path to source file, relative from `$SOURCE_DIR`.
    - `$2` (`<DEST>`) - **optional**, path to destination file, relative from `$DEST_DIR`, will be same as `$1` if omitted.
    - Return codes:
        - **0**: successful copy
        - **2**: source file does not exist
    - Exit codes:
        - **3**: mandatory positional argument was not provided
        - **4**: mandatory environment variable was not provided
        - **93**: destination file already exist
- `esh_symlink_file <SRC> [<DEST>]` : create symbolic link from source file to destination file
    - `$SOURCE_DIR` : directory to create source file path from
    - `$DEST_DIR` : directory to create destination file path from
    - `$1` (`<SRC>`) : path to source file, relative from `$SOURCE_DIR`
    - `$2` (`<DEST>`) : **optional**, path to destination file, relative from `$DEST_DIR`, will be same as `$1` if omitted
    -  Return codes:
        - **0**: successful symbolic link
    - Exit codes:
        - **3**: mandatory positional argument was not provided
        - **4**: mandatory environment variable was not provided
        - **93**: source file does not exist
        - **93**: destination file already exist
- `esh_remove_symlink <LINK>` : remove symbolic link
    -  `$DEST_DIR` : directory to create symbolic link file path from
    - `$1` : path to symbolic link file, relative from `$DEST_DIR`
    - Return codes:
        - **0**: successful removal of symbolic link
    - Exit codes:
        - **3**: mandatory positional argument was not provided
        - **4**: mandatory environment variable was not provided
        - **93**: file was not found
        - **93**: file was not a symbolic link
- `esh_replace_symlink <SRC> [<DEST>]` : create or replace symbolic link from destination file to source file.
    - Ask for confirmation before removing an existing symbolic link.
    - Will skip symbolic links already pointing to the wanted source file.
    - `$SOURCE_DIR` : directory to create source file path from
    - `$DEST_DIR` : directory to create destination file path from
    - `$1` (`<SRC>`) : path to source file, relative from `$SOURCE_DIR`
    - `$2` (`<DEST>`) : **optional**, path to destination file, relative from `$DEST_DIR`, will be same as $1 if omitted
    - Return codes:
        - **0**: successful symbolic link
        - **3**: unknown answer after prompt
    - Exit codes:
        - **3**: mandatory positional argument was not provided
        - **4**: mandatory environment variable was not provided
        - **93**: source file does not exist

### functions.sh
- Included with `source "$ESSENSHELL_PATH/functions.sh"`
- `esh_assert_function_exist <NAME>` : assert that function exist
    - `$1` : function name
    - Return code:
        - **0**: function was found
    - Exit code:
        - **93**: function was not found
- `esh_execution_for_each_n_args <FUNC_NAME> <NUM_ARGS> [<ARG>...]` : execute function with every chunk of provided number of arguments
    - `$1` : string, name of function to execute
    - `$2` : number, number of arguments to use for each invokation
    - `$3+` : optional, list of arguments to provide to function invokations
    - Return codes:
        - **0**: if all executions were successful
    - Exit codes:
        - **93**: function with provided name was not found
        - **93**: number of arguments were not evenly divisible by provided number
- `esh_execution_for_each_arg <FUNC_NAME> [<ARG>...]` : execute function with every provided argument
    - `$1` : string, name of function to execute
    - `$2+` : optional, list of arguments to provide to function invokations
    - Return codes:
        - **0**: if all executions were successful
    - Exit codes:
        - **93**: function with provided name was not found
- `esh_execution_for_each_two_args <FUNC_NAME> [<ARG>...]` : execute function chunk of every two provided arguments
    - variant with three arguments: `esh_execution_for_each_three_args`
    - variant with four arguments: `esh_execution_for_each_four_args`
    - variant with five arguments: `esh_execution_for_each_five_args`
    - variant with six arguments: `esh_execution_for_each_six_args`
    - `$1` : string, name of function to execute
    - `$2+` : optional, list of arguments to provide to function invokations
    - Return codes:
        - **0**: if all executions were successful
    - Exit codes:
        - **93**: function with provided name was not found
        - **93**: number of arguments were not evenly divisible by provided number

### print.sh
- Included with `source "$ESSENSHELL_PATH/print.sh"`
- `env ESH_DEBUG=true ./myScript.sh` - enable debug prints
- Variables:
    - `ESH_DEBUG`
        - set to true to enable debug prints, false by default
        - keeps its original value if set before sourcing `essenshell.sh`
    - `ESH_CLEAR` - normal text
    - `ESH_BOLD` - bold text
    - `ESH_BLACK` - black foreground
    - `ESH_RED` - red foreground
    - `ESH_GREEN` - green foreground
    - `ESH_YELLOW` - yellow foreground
    - `ESH_BLUE` - blue foreground
    - `ESH_MAGENTA` - magenta foreground
    - `ESH_CYAN` - cyan foreground
    - `ESH_WHITE` - white foreground
    - `ESH_BRIGHT_BLACK` - bright black foreground
    - `ESH_BRIGHT_RED` - bright red foreground
    - `ESH_BRIGHT_GREEN` - bright green foreground
    - `ESH_BRIGHT_YELLOW` - bright yellow foreground
    - `ESH_BRIGHT_BLUE` - bright blue foreground
    - `ESH_BRIGHT_MAGENTA` - bright magenta foreground
    - `ESH_BRIGHT_CYAN` - bright cyan foreground
    - `ESH_BRIGHT_WHITE` - bright white foreground
    - `ESH_BOLD_BLACK` - bold black foreground
    - `ESH_BOLD_RED` - bold red foreground
    - `ESH_BOLD_GREEN` - bold green foreground
    - `ESH_BOLD_YELLOW` - bold yellow foreground
    - `ESH_BOLD_BLUE` - bold blue foreground
    - `ESH_BOLD_MAGENTA` - bold magenta foreground
    - `ESH_BOLD_CYAN` - bold cyan foreground
    - `ESH_BOLD_WHITE` - bold white foreground
    - `ESH_BOLD_BRIGHT_BLACK` - bold bright black foreground
    - `ESH_BOLD_BRIGHT_RED` - bold bright red foreground
    - `ESH_BOLD_BRIGHT_GREEN` - bold bright green foreground
    - `ESH_BOLD_BRIGHT_YELLOW` - bold bright yellow foreground
    - `ESH_BOLD_BRIGHT_BLUE` - bold bright blue foreground
    - `ESH_BOLD_BRIGHT_MAGENTA` - bold bright magenta foreground
    - `ESH_BOLD_BRIGHT_CYAN` - bold bright cyan foreground
    - `ESH_BOLD_BRIGHT_WHITE` - bold bright white foreground
- Functions:
    - `esh_print_info <STRING>` - print string as info message
    - `esh_print_warning <STRING>` - print string as warning message
    - `esh_print_error <STRING>` - print string as error message
    - `esh_print_debug <STRING>` - print string as debug message if debug enabled (`ESH_DEBUG`)
    - `esh_set_app_name <STRING>` - set application name, resets if no or empty string
    - `esh_set_app_color <COLOR>` - set application color, only accept valid colors

### variables.sh
- Included with `source "$ESSENSHELL_PATH/variables.sh"`

#### variables.sh functions
- `esh_mandatory_arg <ARGN> <ERRMSG> [<ARG>...]` : check if positional argument is provided, otherwise exit script
    - `$1` (`<ARGN>`) : **number**, the position of the mandatory argument
    - `$2` (`<ERRMSG>`) : error message to print if mandatory argument is missing
    - `$3`+ (`<ARG>...`) : **optional**, list of arguments to check, commonly called with: `"$@"`
    - Return codes:
        - **0**: argument sucessfully found
        - **1**: exit code, mandatory positional variables are unspecified
        - **2**: exit code, provided argument position was not a number
        - **3**: exit code, requested mandatory argument was not provided
- `esh_assign_mandatory_arg <ARGN> <VAR> <ERRMSG> [<ARG>...]` : try to assign positional argument to provided variable, or show error and exit script
    - Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
    - `$1` (`<ARGN>`) : **number**, the position of the mandatory argument
    - `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
    - `$3` (`<ERRMSG>`) : error message to print if mandatory argument is missing
    - `$4`+ (`<ARG>...`) : **optional**, list of arguments to check, commonly called with: `"$@"`
    - Return codes:
        - **0**: variable successfully assigned
        - **1**: exit code, mandatory positional variables are unspecified
        - **2**: exit code, provided argument position was not a number
        - **3**: exit code, requested mandatory argument was not provided
- `esh_assign_optional_arg <ARGN> <VAR> <DEFAULT> [<ARG>...]` : assign either positional argument or default value to provided variable
    - Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
    - `$1` (`<ARGN>`) : **number**, the position of the optional argument
    - `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
    - `$3` (`<DEFAULT>`) : default value to assign to variable
    - `$4`+ (`<ARG>...`) : **optional**, list of arguments to check, commonly called with: `"$@"`
    - Return codes:
        - **0**: variable successfully assigned
        - **1**: exit code, mandatory positional variables are unspecified
        - **2**: exit code, provided argument position was not a number
- `esh_mandatory_env <ENV_NAME>` : check if environment variable is defined, otherwise exit script
    - `$1` : **string**, name of the environment variable to check
    - Return codes:
        - **0**: environment variable is set
        - **1**: exit code, mandatory positional variables are unspecified
        - **4**: exit code, mandatory environment variable is undefined
- `esh_args_divisible_by <DIVISOR> [<ARG>...]` : assert that number of arguments are evenly dividable by the divisor
    - `$1` : number, divisor to be evenly dividable by
    - `$2+` : optional, list of arguments to check, commonly called with: `"$@"`
    - Return codes:
        - **0**: number of arguments are evenly dividable by the divisor
    - Exit codes:
        - **93**: number of argument are not evenly dividable by the divisor

## Test
- Dependencies: `docker`
- `test/ut.sh` - run unit tests in `docker` container
- `test/cov.sh` - run coverage test in `docker` container
- `test/manual.sh` - run tests with output for manual verification
- `.simplecov` - configuration for coverage test
