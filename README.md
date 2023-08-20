# Essenshell

Essenshell is a shell library containing the most common and essential functions.

## Usage
- `source essenshell.sh` - include and start using the library in a script
- use [variables](#variables) or [functions](#functions) as described below
- `env ESH_DEBUG=true ./myScript.sh` - enable debug prints

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

### Functions
- `esh_version` - print version of essenshell
- `esh_print_info <STRING>` - print string as info message
- `esh_print_warning <STRING>` - print string as warning message
- `esh_print_error <STRING>` - print string as error message
- `esh_print_debug <STRING>` - print string as debug message if debug enabled (`ESH_DEBUG`)
- functions beginning with an underscore are private functions and are only intended for internal use, do not call directly since their APIs are not stable

## Test
- Dependencies: `bats-core`, `bats-support`, and `bats-assert`
- `bats` binary must be in path
- `bats-support`, and `bats-assert` must be in directory specified by `BATS_LIB_PATH`, or in `/usr/local/lib`
- `test/ut.sh` - run unit tests
- `test/manual.sh` - run tests with output for manual verification
