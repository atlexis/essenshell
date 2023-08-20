#!/usr/bin/env bats

clear="\033[0m"
black="\033[30;m"
red="\033[31;m"
green="\033[32;m"
yellow="\033[33;m"
blue="\033[34;m"
magenta="\033[35;m"
cyan="\033[36;m"
white="\033[37;m"

function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    local dir=$(dirname "$BATS_TEST_FILENAME")
    source ${dir}/../essenshell.sh
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
    assert_print "$green" "INFO" "$@"
}

function assert_warning_print {
    assert_print "$yellow" "WARNING" "$@"
}

function assert_error_print {
    assert_print "$red" "ERROR" "$@"
}

function assert_debug_print {
    assert_print "$magenta" "DEBUG" "$@"
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

    refute_output
}

@test "debug print enabled" {
    ESH_DEBUG=true

    run esh_print_debug "this should be seen"

    assert_debug_print "this should be seen"
}

@test "debug print disabled" {
    ESH_DEBUG=false

    run esh_print_debug "this should not be seen"

    refute_output
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

    refute_output
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
    esh_set_app_color $ESH_COLOR_BLACK

    run esh_print_info "foo bar baz"

    assert_info_print "$black" "FOOBAR" "foo bar baz"
}

@test "warning print with app name in black color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_BLACK

    run esh_print_warning "foo bar baz"

    assert_warning_print "$black" "FOOBAR" "foo bar baz"
}

@test "error print with app name in black color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_BLACK

    run esh_print_error "foo bar baz"

    assert_error_print "$black" "FOOBAR" "foo bar baz"
}

@test "enabled debug print with app name in black color" {
    ESH_DEBUG=true
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_BLACK

    run esh_print_debug "foo bar baz"

    assert_debug_print "$black" "FOOBAR" "foo bar baz"
}

@test "disabled debug print with app name in black color" {
    ESH_DEBUG=false
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_BLACK

    run esh_print_debug "foo bar baz"

    refute_output
}

@test "set app name in red color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_RED

    run esh_print_info "foo bar baz"

    assert_info_print "$red" "FOOBAR" "foo bar baz"
}

@test "set app name in green color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_GREEN

    run esh_print_info "foo bar baz"

    assert_info_print "$green" "FOOBAR" "foo bar baz"
}

@test "set app name in yellow color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_YELLOW

    run esh_print_info "foo bar baz"

    assert_info_print "$yellow" "FOOBAR" "foo bar baz"
}

@test "set app name in blue color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_BLUE

    run esh_print_info "foo bar baz"

    assert_info_print "$blue" "FOOBAR" "foo bar baz"
}

@test "set app name in magenta color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_MAGENTA

    run esh_print_info "foo bar baz"

    assert_info_print "$magenta" "FOOBAR" "foo bar baz"
}

@test "set app name in cyan color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_CYAN

    run esh_print_info "foo bar baz"

    assert_info_print "$cyan" "FOOBAR" "foo bar baz"
}

@test "set app name in white color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color $ESH_COLOR_WHITE

    run esh_print_info "foo bar baz"

    assert_info_print "$white" "FOOBAR" "foo bar baz"
}

@test "set app name in invalid color" {
    esh_set_app_name "FOOBAR"
    esh_set_app_color "INVALID_COLOR"

    run esh_print_info "foo bar baz"

    assert_info_print "FOOBAR" "foo bar baz"
}

@test "set app color without app name" {
    esh_set_app_color "$ESH_COLOR_CYAN"

    run esh_print_info "foo bar baz"

    assert_info_print "foo bar baz"
}
