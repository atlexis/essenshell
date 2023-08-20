#!/usr/bin/env bats

clear="\033[0m"
red="\033[31;m"
green="\033[32;m"
yellow="\033[33;m"

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
