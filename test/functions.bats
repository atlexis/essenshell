function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    source "$ESSENSHELL_PATH/functions.sh"
}

# Dummy function used by tests
function foo_bar_baz {
    :
}

@test "function exist" {
    run esh_assert_function_exist foo_bar_baz
    assert_success
    assert_output
}

@test "function does not exist" {
    run esh_assert_function_exist made_up_name
    assert_failure 93
    assert_output --partial "Function does not exist"
}

@test "missing argument when checking if function exist" {
    run esh_assert_function_exist
    assert_failure 3
    assert_output --partial "function to check if it exists"
}
