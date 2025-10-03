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

@test "missing function name when executing for each argument" {
    run esh_execute_for_each_n_args
    assert_failure 3
    assert_output --partial "function to execute with each argument"
}

@test "non-existing function name when executing for each argument" {
    run esh_execute_for_each_n_args made_up_name
    assert_failure 93
    assert_output --partial "Function does not exist"
}

@test "missing number of arguments when executing for each argument" {
    run esh_execute_for_each_n_args foo_bar_baz
    assert_failure 3
    assert_output --partial "number of parameters per execution"
}

@test "arguments not evenly divisible when executing for each argument" {
    run esh_execute_for_each_n_args foo_bar_baz 2 "one" "two" "three"
    assert_failure 93
    assert_output --partial "Number of elements is not divisible by"
}

function_call_count=0
function assert_two_arguments {
    ((function_call_count+=1))
    assert_equal "$1" "foo"
    assert_equal "$2" "bar"
}

@test "execute for each two arguments" {
    esh_execute_for_each_n_args assert_two_arguments 2 "foo" "bar" "foo" "bar"
    assert_equal "$function_call_count" 2
}

@test "execute for each two arguments with no arguments" {
    esh_execute_for_each_n_args assert_two_arguments 2
    assert_equal "$function_call_count" 0
}
