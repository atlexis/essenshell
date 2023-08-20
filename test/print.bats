#!/usr/bin/env bats

clear="\033[0m"
red="\033[31;m"
green="\033[32;m"
yellow="\033[33;m"
magenta="\033[35;m"

function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    local dir=$(dirname "$BATS_TEST_FILENAME")
    source ${dir}/../essenshell.sh
}

function assert_prompt_print {
    local color=$1
    local prompt=$2
    local message=$3
    local expected=$(echo -e "[${color}${prompt}${clear}] ${message}")
    assert_output "$expected"
}

function assert_app_prompt_print {
    local app_name=$1
    local color=$2
    local prompt=$3
    local message=$4
    local expected=$(echo -e "[${app_name}:${color}${prompt}${clear}] ${message}")
    assert_output "$expected"
}

function assert_info_print {
    local message=$1
    assert_prompt_print "$green" "INFO" "$message"
}

function assert_warning_print {
    local message=$1
    assert_prompt_print "$yellow" "WARNING" "$message"
}

function assert_error_print {
    local message=$1
    assert_prompt_print "$red" "ERROR" "$message"
}

function assert_debug_print {
    local message=$1
    assert_prompt_print "$magenta" "DEBUG" "$message"
}

function assert_app_info_print {
    local app_name=$1
    local message=$2
    assert_app_prompt_print "$app_name" "$green" "INFO" "$message"
}

function assert_app_warning_print {
    local app_name=$1
    local message=$2
    assert_app_prompt_print "$app_name" "$yellow" "WARNING" "$message"
}

function assert_app_error_print {
    local app_name=$1
    local message=$2
    assert_app_prompt_print "$app_name" "$red" "ERROR" "$message"
}

function assert_app_debug_print {
    local app_name=$1
    local message=$2
    assert_app_prompt_print "$app_name" "$magenta" "DEBUG" "$message"
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
    ESH_APP_NAME="Tester"

    run esh_print_info "foo bar baz"

    assert_app_info_print "Tester" "foo bar baz"
}

@test "warning print with app name" {
    ESH_APP_NAME="Tester"

    run esh_print_warning "foo bar baz"

    assert_app_warning_print "Tester" "foo bar baz"
}

@test "error print with app name" {
    ESH_APP_NAME="Tester"

    run esh_print_error "foo bar baz"

    assert_app_error_print "Tester" "foo bar baz"
}

@test "enabled debug print with app name" {
    ESH_DEBUG=true
    ESH_APP_NAME="Tester"

    run esh_print_debug "foo bar baz"

    assert_app_debug_print "Tester" "foo bar baz"
}

@test "disabled debug print with app name" {
    ESH_DEBUG=false
    ESH_APP_NAME="Tester"

    run esh_print_debug "foo bar baz"

    refute_output
}

@test "set app name with function" {
    esh_set_app_name "MyApp"

    run esh_print_info "foo bar baz"

    assert_app_info_print "MyApp" "foo bar baz"
}

@test "overwrite app name with function" {
    esh_set_app_name "MyApp"
    esh_set_app_name "AnotherName"

    run esh_print_info "foo bar baz"

    assert_app_info_print "AnotherName" "foo bar baz"
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
