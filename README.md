# Essenshell

Essenshell is a shell library containing the most common and essential functions.

## Usage
- `source essenshell.sh` - include and start using the library in a script.

### Variables
- `ESH_VERSION` - version of essenshell
- `ESH_CLEAR` - ANSI escape sequence for normal text
- `ESH_COLOR_GREEN` - ANSI escape sequence for green foreground
- `ESH_COLOR_YELLOW` - ANSI escape sequence for yellow foreground

### Functions
- `esh_version` - print version of essenshell
- `esh_print_info <STRING>` - print string as info message
- `esh_print_warning <STRING>` - print string as warning message

## Test
- Dependencies: `bats-core`, `bats-support`, and `bats-assert`
- `bats` binary must be in path
- `bats-support`, and `bats-assert` must be in directory specified by `BATS_LIB_PATH`, or in `/usr/local/lib`
- `test/ut.sh` - run unit tests
