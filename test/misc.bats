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

@test "checked input is a number" {
    run esh_check_number 9876
    assert_success
}

@test "checked input is 0" {
    run esh_check_number 0
    assert_success
}

@test "checked input is not a number" {
    run esh_check_number "foobar"
    assert_failure 1
}

@test "checked input is missing" {
    run esh_check_number
    assert_failure 93
}

@test "checked input is empty" {
    run esh_check_number ""
    assert_failure 1
}

@test "asserted input is a number" {
    run esh_assert_number 1337
    assert_success
}

@test "asserted input is 0" {
    run esh_assert_number 0
    assert_success
}

@test "asserted input is not a number" {
    run esh_assert_number "foobar"
    assert_failure 93
}

@test "asserted input is missing" {
    run esh_assert_number
    assert_failure 93
}

@test "asserted input is empty" {
    run esh_assert_number ""
    assert_failure 93
}
