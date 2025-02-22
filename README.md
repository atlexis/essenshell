# Essenshell

Essenshell is a shell library containing the most common and essential functions.

## Installation
- Run `./install.sh` to install files on the system.
- Installation directory is determined in following priority order:
    1. First positional argument `./install.sh /Path/To/Install/essenshell-0.1`
    2. Default directory, `$HOME/.local/opt/essenshell-<VERSION>`: `./install.sh`

## Usage
- `source essenshell.sh` - include and start using the library in a script
- use [variables](#variables) or [functions](#functions) as described below
- `env ESH_DEBUG=true ./myScript.sh` - enable debug prints

### Variables
- variables beginning with an underscore are private variables and are only intended for internal use, do not use directly since their APIs are not stable
- `ESH_VERSION` - version of essenshell
- `ESH_DEBUG`
    - set to true to enable debug prints, false by default
    - keeps its original value if set before sourcing `essenshell.sh`

### Color Variables
- ANSI escaped sequences
- `ESH_CLEAR` - normal text
- `ESH_COLOR_BLACK` - black foreground
- `ESH_COLOR_RED` - red foreground
- `ESH_COLOR_GREEN` - green foreground
- `ESH_COLOR_YELLOW` - yellow foreground
- `ESH_COLOR_BLUE` - blue foreground
- `ESH_COLOR_MAGENTA` - magenta foreground
- `ESH_COLOR_CYAN` - cyan foreground
- `ESH_COLOR_WHITE` - white foreground

### Functions
- functions beginning with an underscore are private functions and are only intended for internal use, do not call directly since their APIs are not stable
- `esh_version` - print version of essenshell
- `esh_print_info <STRING>` - print string as info message
- `esh_print_warning <STRING>` - print string as warning message
- `esh_print_error <STRING>` - print string as error message
- `esh_print_debug <STRING>` - print string as debug message if debug enabled (`ESH_DEBUG`)
- `esh_set_app_name <STRING>` - set application name, resets if no or empty string
- `esh_set_app_color <COLOR>` - set application color, only accept [valid colors](#color-variables)

## Test
- Dependencies: `docker`
- `test/ut.sh` - run unit tests in `docker` container
- `test/cov.sh` - run coverage test in `docker` container
- `test/manual.sh` - run tests with output for manual verification
- `.simplecov` - configuration for coverage test
