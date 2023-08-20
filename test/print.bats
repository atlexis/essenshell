#!/usr/bin/env bats

clear="\033[0m"
green="\033[32;m"
yellow="\033[33;m"

function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    local dir=$(dirname "$BATS_TEST_FILENAME")
    source ${dir}/../essenshell.sh
}

function assert_info_print {
    local message=$1
    local info_prompt="INFO"
    local expected=$(echo -e "[${green}${info_prompt}${clear}] ${message}")
    assert_output "$expected"
}

function assert_warning_print {
    local message=$1
    local warning_prompt="WARNING"
    local expected=$(echo -e "[${yellow}${warning_prompt}${clear}] ${message}")
    assert_output "$expected"
}

@test "info print 1" {
    run esh_print_info "foo"

    assert_info_print "foo"
}

@test "info print 2" {
    run esh_print_info "bar"

    assert_info_print "bar"
}

@test "warning print 1" {
    run esh_print_warning "foo"

    assert_warning_print "foo"
}

@test "warning print 2" {
    run esh_print_warning "bar"

    assert_warning_print "bar"
}
