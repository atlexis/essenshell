# Essenshell

Essenshell is a shell library containing the most common and essential functions.

## Usage
- `source essenshell.sh` - include and start using the library in a script
- use [variables](#variables) or [functions](#functions) as described below
- `env ESH_DEBUG=true ./myScript.sh` - enable debug prints
- `env ESH_APP_NAME=<NAME> ./myScript.sh` - set application name before running script

### Variables
- `ESH_VERSION` - version of essenshell
- `ESH_CLEAR` - ANSI escape sequence for normal text
- `ESH_COLOR_GREEN` - ANSI escape sequence for green foreground
- `ESH_COLOR_YELLOW` - ANSI escape sequence for yellow foreground
- `ESH_COLOR_RED` - ANSI escape sequence for red foreground
- `ESH_COLOR_MAGENTA` - ANSI escape sequence for magenta foreground
- `ESH_DEBUG`
    - set to true to enable debug prints, false by default
    - keeps its original value if set before sourcing `essenshell.sh`
- `ESH_APP_NAME` - name of application to show in prints

### Functions
- `esh_version` - print version of essenshell
- `esh_print_info <STRING>` - print string as info message
- `esh_print_warning <STRING>` - print string as warning message
- `esh_print_error <STRING>` - print string as error message
- `esh_print_debug <STRING>` - print string as debug message if debug enabled (`ESH_DEBUG`)
- `esh_set_app_name <STRING>` - set application name, resets if no or empty string
- functions beginning with an underscore are private functions and are only intended for internal use, do not call directly since their APIs are not stable

## Test
- Dependencies: `bats-core`, `bats-support`, and `bats-assert`
- `bats` binary must be in path
- `bats-support`, and `bats-assert` must be in directory specified by `BATS_LIB_PATH`, or in `/usr/local/lib`
- `test/ut.sh` - run unit tests
- `test/manual.sh` - run tests with output for manual verification
