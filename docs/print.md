# `print.sh` documentation

- Included with `source "$ESSENSHELL_PATH/print.sh"`
- `env ESH_DEBUG=true ./myScript.sh` - enable debug prints

## Variables
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

## Functions
- `esh_print_info <STRING>` - print string as info message
- `esh_print_warning <STRING>` - print string as warning message
- `esh_print_error <STRING>` - print string as error message
- `esh_print_debug <STRING>` - print string as debug message if debug enabled (`ESH_DEBUG`)
- `esh_set_app_name <STRING>` - set application name, resets if no or empty string
- `esh_set_app_color <COLOR>` - set application color, only accept valid colors
