#!/usr/bin/env bats

green="\033[32;m"
clear="\033[0m"

function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    local dir=$(dirname "$BATS_TEST_FILENAME")
    source ${dir}/../essenshell.sh
}

function assert_info_print {
    local message=$1
    local expected=$(echo -e "[${green}INFO${clear}] ${message}")
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
