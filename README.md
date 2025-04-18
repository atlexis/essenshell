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
    - [print.sh](#printsh)

### files.sh
- Included with `source "$ESSENSHELL_PATH/files.sh"`

### files.sh functions:
- `esh_copy_file <SRC> [<DEST>]` : copy file or directory recursively from source file to destination file
    - `$SOURCE_DIR` : directory to create source file path from
    - `$DEST_DIR` : directory to create destination file path form
    - `$1` (`<SRC>`) - path to source file, relative from `$SOURCE_DIR`.
    - `$2` (`<DEST>`) - **optional**, path to destination file, relative from `$DEST_DIR`, will be same as `$1` if omitted.
    - Return codes:
        - **0**: successful copy
        - **1**: mandatory environmental and positional variables are unspecified
        - **2**: source file does not exist
        - **3**: destination file already exists
- `esh_symlink_file <SRC> [<DEST>]` : create symbolic link from source file to destination file
    - `$SOURCE_DIR` : directory to create source file path from
    - `$DEST_DIR` : directory to create destination file path from
    - `$1` (`<SRC>`) : path to source file, relative from `$SOURCE_DIR`
    - `$2` (`<DEST>`) : **optional**, path to destination file, relative from `$DEST_DIR`, will be same as `$1` if omitted
    -  Return codes:
        - **0**: successful symbolic link
        - **1**: mandatory environmental and positional variables are unspecified
        - **2**: source file does not exist
        - **3**: destination file already exists
- `esh_remove_symlink <LINK>` : remove symbolic link
    -  `$DEST_DIR` : directory to create symbolic link file path from
    - `$1` : path to symbolic link file, relative from `$DEST_DIR`
    - Return codes:
        - **0**: successful removal of symbolic link
        - **1**: mandatory environmental and positional variables are unspecified
        - **2**: symbolic link to remove does not exist
        - **3**: symbolic link to remove is not a symbolic link
- `esh_replace_symlink <SRC> [<DEST>]` : create or replace symbolic link from destination file to source file.
    - Ask for confirmation before removing an existing symbolic link.
    - Will skip symbolic links already pointing to the wanted source file.
    - `$SOURCE_DIR` : directory to create source file path from
    - `$DEST_DIR` : directory to create destination file path from
    - `$1` (`<SRC>`) : path to source file, relative from `$SOURCE_DIR`
    - `$2` (`<DEST>`) : **optional**, path to destination file, relative from `$DEST_DIR`, will be same as $1 if omitted
    - Return codes:
        - **0**: successful symbolic link
        - **1**: mandatory environmental and positional variables are unspecified
        - **2**: source file does not exist
        - **3**: unknown answer after prompt

### print.sh
- Included with `source "$ESSENSHELL_PATH/print.sh"`
- `env ESH_DEBUG=true ./myScript.sh` - enable debug prints
- Variables:
    - `ESH_DEBUG`
        - set to true to enable debug prints, false by default
        - keeps its original value if set before sourcing `essenshell.sh`
    - `ESH_CLEAR` - normal text
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
    - # Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
    - `$1` (`<ARGN>`) : **number**, the position of the optional argument
    - `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
    - `$3` (`<DEFAULT>`) : default value to assign to variable
    - `$4`+ (`<ARG>...`) : **optional**, list of arguments to check, commonly called with: `"$@"`
    - Return codes:
        - **0**: variable successfully assigned
        - **1**: exit code, mandatory positional variables are unspecified
        - **2**: exit code, provided argument position was not a number

## Test
- Dependencies: `docker`
- `test/ut.sh` - run unit tests in `docker` container
- `test/cov.sh` - run coverage test in `docker` container
- `test/manual.sh` - run tests with output for manual verification
- `.simplecov` - configuration for coverage test
