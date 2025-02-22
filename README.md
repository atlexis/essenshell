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
- `source essenshell.sh` - include the [entire library](#global).
- `source files.sh` - include the [files sub-library](#filessh)
- `source print.sh` - include the [print sub-library](#printsh)
- **Note**: Sourced variables and functions beginning with an underscore are private variables and are only intended for internal use, do not rely on these directly since their APIs are not stable and might change at any time.

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
- Functions:
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

### print.sh
- Included with `source "$ESSENSHELL_PATH/print.sh"`
- `env ESH_DEBUG=true ./myScript.sh` - enable debug prints
- Variables:
    - `ESH_DEBUG`
        - set to true to enable debug prints, false by default
        - keeps its original value if set before sourcing `essenshell.sh`
    - `ESH_CLEAR` - normal text
    - `ESH_COLOR_BLACK` - black foreground
    - `ESH_COLOR_RED` - red foreground
    - `ESH_COLOR_GREEN` - green foreground
    - `ESH_COLOR_YELLOW` - yellow foreground
    - `ESH_COLOR_BLUE` - blue foreground
    - `ESH_COLOR_MAGENTA` - magenta foreground
    - `ESH_COLOR_CYAN` - cyan foreground
    - `ESH_COLOR_WHITE` - white foreground
- Functions:
    - `esh_print_info <STRING>` - print string as info message
    - `esh_print_warning <STRING>` - print string as warning message
    - `esh_print_error <STRING>` - print string as error message
    - `esh_print_debug <STRING>` - print string as debug message if debug enabled (`ESH_DEBUG`)
    - `esh_set_app_name <STRING>` - set application name, resets if no or empty string
    - `esh_set_app_color <COLOR>` - set application color, only accept valid colors

## Test
- Dependencies: `docker`
- `test/ut.sh` - run unit tests in `docker` container
- `test/cov.sh` - run coverage test in `docker` container
- `test/manual.sh` - run tests with output for manual verification
- `.simplecov` - configuration for coverage test
