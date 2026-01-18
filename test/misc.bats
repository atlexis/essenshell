function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    source "$ESSENSHELL_PATH/misc.sh"
}

@test "correct version variable" {
    assert [ $ESSENSHELL_VERSION = 0.1.0 ]
}

@test "correct version function" {
    run esh_version
    assert_output "0.1.0"
}

@test "input is a number" {
    run esh_assert_number 1337
    assert_success
}

@test "input is 0" {
    run esh_assert_number 0
    assert_success
}

@test "input is not a number" {
    run esh_assert_number "foobar"
    assert_failure 93
}

@test "input is missing" {
    run esh_assert_number
    assert_failure 93
}

@test "input is empty" {
    run esh_assert_number ""
    assert_failure 93
}
