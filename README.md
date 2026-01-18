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
    - [`files.sh`](/docs/files.md) - file-related functions
    - [`functions.sh`](/docs/functions.md) - function-related functions
    - [`input.sh`](/docs/input.md) - user-input-related functions
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
- `templates/simple_essenshell_path`
    - verify that `$ESSENSHELL_PATH/essenshell.sh` exist
    - source `$ESSENSHELL_PATH/essenshell.sh` into script

### Global
- Included with `source essenshell.sh`
- Variables:
    - `ESSENSHELL_VERSION` - current version of essenshell
- Functions:
- `esh_version` - print version of essenshell
- Includes all sub-libraries

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
- `esh_assign_mandatory_env <ENV_NAME> <VAR>` : try to assign environment variable to provided variable, or show error and exit script
    - Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
    - `$1` (`<ENV_NAME>`) : **string**, name of the environment variable to assign from
    - `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
    - Return codes:
        - **0** : variable successfully assigned
        - **3** : exit code, requested mandatory arguments were not provided
        - **4** : exit code, mandatory environment variable is undefined
- `esh_assign_optional_env <ENV_NAME> <VAR> <DEFAULT>` : assign either environment variable or default value to provided variable
    - Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
    - `$1` (`<ENV_NAME>`) : **string**, name of the environment variable to assign from
    - `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
    - `$3` (`<DEFAULT>`) : default value to assign to variable
    - Return codes:
        - **0** : variable successfully assigned
        - **3** : exit code, requested mandatory arguments were not provided
- `esh_args_divisible_by <DIVISOR> [<ARG>...]` : assert that number of arguments are evenly dividable by the divisor
    - `$1` : number, divisor to be evenly dividable by
    - `$2+` : optional, list of arguments to check, commonly called with: `"$@"`
    - Return codes:
        - **0**: number of arguments are evenly dividable by the divisor
    - Exit codes:
        - **93**: number of argument are not evenly dividable by the divisor

## Test
- Dependencies: `docker`
- `docker build -t essenshell .` - build Docker image, only once
- `docker run -v $(pwd):/app:ro essenshell bats test` - run unit tests in Docker container
- `docker run -v $(pwd):/app essenshell bashcov -- bats test` - run unit test and code coverage in Docker container
    - open `coverage/index.html` in browser to see results
- Convenience scripts:
    - `test/manual.sh` - run tests with output for manual verification
- `.simplecov` - configuration for coverage test
