clear="\033[0m"
black="\033[30m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"

bright_black="\033[90m"
bright_red="\033[91m"
bright_green="\033[92m"
bright_yellow="\033[93m"
bright_blue="\033[94m"
bright_magenta="\033[95m"
bright_cyan="\033[96m"
bright_white="\033[97m"

bold_black="\033[1;30m"
bold_red="\033[1;31m"
bold_green="\033[1;32m"
bold_yellow="\033[1;33m"
bold_blue="\033[1;34m"
bold_magenta="\033[1;35m"
bold_cyan="\033[1;36m"
bold_white="\033[1;37m"

bold_bright_black="\033[1;90m"
bold_bright_red="\033[1;91m"
bold_bright_green="\033[1;92m"
bold_bright_yellow="\033[1;93m"
bold_bright_blue="\033[1;94m"
bold_bright_magenta="\033[1;95m"
bold_bright_cyan="\033[1;96m"
bold_bright_white="\033[1;97m"

function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    source "$ESSENSHELL_PATH/essenshell.sh"
}

function assert_prompt_print {
    local expected=""

    if [ $# -eq 3 ]; then # no app prompt
        local color=$1
        local prompt=$2
        local message=$3
        expected=$(echo -e "[${color}${prompt}${clear}] ${message}")
    elif [ $# -eq 4 ]; then # app prompt without color
        local app_name=$1
        local color=$2
        local prompt=$3
        local message=$4
        expected=$(echo -e "[${app_name}:${color}${prompt}${clear}] ${message}")
    elif [ $# -eq 5 ]; then # app prompt with color
        local app_color=$1
        local app_name=$2
        local color=$3
        local prompt=$4
        local message=$5
        expected=$(echo -e "[${app_color}${app_name}${clear}:${color}${prompt}${clear}] ${message}")
    fi

    assert_output "$expected"
}

function assert_print {
    local color=$1
    local prompt=$2

    if [ $# -eq 3 ]; then
        local message=$3
        assert_prompt_print "$color" "$prompt" "$message"
    elif [ $# -eq 4 ]; then
        local app_name=$3
        local message=$4
        assert_prompt_print "$app_name" "$color" "$prompt" "$message"
    elif [ $# -eq 5 ]; then
        local app_color=$3
        local app_name=$4
        local message=$5
        assert_prompt_print "$app_color" "$app_name" "$color" "$prompt" "$message"
    fi
}

function assert_info_print {
    assert_print "$bold_bright_green" "INFO" "$@"
}

function assert_warning_print {
    assert_print "$bold_bright_yellow" "WARNING" "$@"
}

function assert_error_print {
    assert_print "$bold_bright_red" "ERROR" "$@"
}

function assert_debug_print {
    assert_print "$bold_bright_magenta" "DEBUG" "$@"
}

function assert_no_output {
    assert_output ""
}

@test "info print 1" {
    run esh_print_info "foo"

    assert_info_print "foo"
}

@test "info print 2" {
    run esh_print_info "this is a sentence"

    assert_info_print "this is a sentence"
}

@test "warning print 1" {
    run esh_print_warning "foo"

    assert_warning_print "foo"
}

@test "warning print 2" {
    run esh_print_warning "this is a sentence"

    assert_warning_print "this is a sentence"
}

@test "error print 1" {
    run esh_print_error "foo"

    assert_error_print "foo"
}

@test "error print 2" {
    run esh_print_error "this is a sentence"

    assert_error_print "this is a sentence"
}

@test "debug print not enabled by default" {
    run esh_print_debug "this should not be seen"

    assert_no_output
}

@test "debug print enabled" {
    ESH_DEBUG=true

    run esh_print_debug "this should be seen"

    assert_debug_print "this should be seen"
}

@test "debug print disabled" {
    ESH_DEBUG=false

    run esh_print_debug "this should not be seen"

    assert_no_output
}

@test "info print with app name" {
    esh_set_app_name "Tester"

    run esh_print_info "foo bar baz"

    assert_info_print "Tester" "foo bar baz"
}

@test "warning print with app name" {
    esh_set_app_name "Tester"

    run esh_print_warning "foo bar baz"

    assert_warning_print "Tester" "foo bar baz"
}

@test "error print with app name" {
    esh_set_app_name "Tester"

    run esh_print_error "foo bar baz"

    assert_error_print "Tester" "foo bar baz"
}

@test "enabled debug print with app name" {
    ESH_DEBUG=true
    esh_set_app_name "Tester"

    run esh_print_debug "foo bar baz"

    assert_debug_print "Tester" "foo bar baz"
}

@test "disabled debug print with app name" {
    ESH_DEBUG=false
    esh_set_app_name "Tester"

    run esh_print_debug "foo bar baz"

    assert_no_output
}

@test "overwrite app name with function" {
    esh_set_app_name "MyApp"
    esh_set_app_name "AnotherName"

    run esh_print_info "foo bar baz"

    assert_info_print "AnotherName" "foo bar baz"
}

@test "set app name with no argument" {
    esh_set_app_name "MyApp"
    esh_set_app_name

    run esh_print_info "foo bar baz"

    assert_info_print "foo bar baz"
}

@test "set app name with empty string" {
    esh_set_app_name "MyApp"
    esh_set_app_name ""

    run esh_print_info "foo bar baz"

    assert_info_print "foo bar baz"
}

@test "info print with app name in black color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BLACK

    run esh_print_info "foo bar baz"

    assert_info_print "$black" "FOOBAR" "foo bar baz"
}

@test "warning print with app name in black color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BLACK

    run esh_print_warning "foo bar baz"

    assert_warning_print "$black" "FOOBAR" "foo bar baz"
}

@test "error print with app name in black color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BLACK

    run esh_print_error "foo bar baz"

    assert_error_print "$black" "FOOBAR" "foo bar baz"
}

@test "enabled debug print with app name in black color" {
    ESH_DEBUG=true
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BLACK

    run esh_print_debug "foo bar baz"

    assert_debug_print "$black" "FOOBAR" "foo bar baz"
}

@test "disabled debug print with app name in black color" {
    ESH_DEBUG=false
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BLACK

    run esh_print_debug "foo bar baz"

    assert_no_output
}

@test "set app name in red color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_RED

    run esh_print_info "foo bar baz"

    assert_info_print "$red" "FOOBAR" "foo bar baz"
}

@test "set app name in green color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_GREEN

    run esh_print_info "foo bar baz"

    assert_info_print "$green" "FOOBAR" "foo bar baz"
}

@test "set app name in yellow color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_YELLOW

    run esh_print_info "foo bar baz"

    assert_info_print "$yellow" "FOOBAR" "foo bar baz"
}

@test "set app name in blue color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BLUE

    run esh_print_info "foo bar baz"

    assert_info_print "$blue" "FOOBAR" "foo bar baz"
}

@test "set app name in magenta color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_MAGENTA

    run esh_print_info "foo bar baz"

    assert_info_print "$magenta" "FOOBAR" "foo bar baz"
}

@test "set app name in cyan color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_CYAN

    run esh_print_info "foo bar baz"

    assert_info_print "$cyan" "FOOBAR" "foo bar baz"
}

@test "set app name in white color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_WHITE

    run esh_print_info "foo bar baz"

    assert_info_print "$white" "FOOBAR" "foo bar baz"
}

@test "set app name in bright black color" {

    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_BLACK

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_black" "FOOBAR" "foo bar baz"
}

@test "set app name in bright red color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_RED

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_red" "FOOBAR" "foo bar baz"
}

@test "set app name in bright green color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_GREEN

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_green" "FOOBAR" "foo bar baz"
}

@test "set app name in bright yellow color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_YELLOW

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_yellow" "FOOBAR" "foo bar baz"
}

@test "set app name in bright blue color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_BLUE

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_blue" "FOOBAR" "foo bar baz"
}

@test "set app name in bright magenta color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_MAGENTA

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_magenta" "FOOBAR" "foo bar baz"
}

@test "set app name in bright cyan color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_CYAN

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_cyan" "FOOBAR" "foo bar baz"
}

@test "set app name in bright white color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BRIGHT_WHITE

    run esh_print_info "foo bar baz"

    assert_info_print "$bright_white" "FOOBAR" "foo bar baz"
}

@test "set app name in bold black color" {

    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BLACK

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_black" "FOOBAR" "foo bar baz"
}

@test "set app name in bold red color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_RED

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_red" "FOOBAR" "foo bar baz"
}

@test "set app name in bold green color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_GREEN

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_green" "FOOBAR" "foo bar baz"
}

@test "set app name in bold yellow color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_YELLOW

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_yellow" "FOOBAR" "foo bar baz"
}

@test "set app name in bold blue color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BLUE

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_blue" "FOOBAR" "foo bar baz"
}

@test "set app name in bold magenta color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_MAGENTA

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_magenta" "FOOBAR" "foo bar baz"
}

@test "set app name in bold cyan color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_CYAN

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_cyan" "FOOBAR" "foo bar baz"
}

@test "set app name in bold white color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_WHITE

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_white" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright black color" {

    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_BLACK

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_black" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright red color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_RED

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_red" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright green color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_GREEN

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_green" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright yellow color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_YELLOW

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_yellow" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright blue color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_BLUE

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_blue" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright magenta color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_MAGENTA

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_magenta" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright cyan color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_CYAN

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_cyan" "FOOBAR" "foo bar baz"
}

@test "set app name in bold bright white color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_BOLD_BRIGHT_WHITE

    run esh_print_info "foo bar baz"

    assert_info_print "$bold_bright_white" "FOOBAR" "foo bar baz"
}

@test "set app name in invalid color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color "INVALID_COLOR"

    run esh_print_info "foo bar baz"

    assert_info_print "FOOBAR" "foo bar baz"
}

@test "set app color without app name" {
    esh_set_app_color "$ESH_CYAN"

    run esh_print_info "foo bar baz"

    assert_info_print "foo bar baz"
}
