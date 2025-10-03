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

function assert_one_argument {
    ((function_call_count+=1))
    assert_equal "$1" "foo"
}

function assert_two_arguments {
    assert_one_argument "$1"
    assert_equal "$2" "bar"
}

function assert_three_arguments {
    assert_two_arguments "$1" "$2"
    assert_equal "$3" "baz"
}

function assert_four_arguments {
    assert_three_arguments "$1" "$2" "$3"
    assert_equal "$4" "qux"
}
function assert_five_arguments {
    assert_four_arguments "$1" "$2" "$3" "$4"
    assert_equal "$5" "quux"
}
function assert_six_arguments {
    assert_five_arguments "$1" "$2" "$3" "$4" "$5"
    assert_equal "$6" "quuz"
}

@test "execute for each N arguments" {
    esh_execute_for_each_n_args assert_two_arguments 2 "foo" "bar" "foo" "bar"
    assert_equal "$function_call_count" 2
}

@test "execute for each N arguments with no arguments" {
    esh_execute_for_each_n_args assert_two_arguments 2
    assert_equal "$function_call_count" 0
}

@test "execute for each argument" {
    esh_execute_for_each_arg assert_one_argument "foo" "foo" "foo"
    assert_equal "$function_call_count" 3
}

@test "execute for each two arguments" {
    esh_execute_for_each_two_args assert_two_arguments "foo" "bar" "foo" "bar" "foo" "bar"
    assert_equal "$function_call_count" 3
}

@test "execute for each three arguments" {
    esh_execute_for_each_three_args assert_three_arguments "foo" "bar" "baz" "foo" "bar" "baz" "foo" "bar" "baz"
    assert_equal "$function_call_count" 3
}

@test "execute for each four arguments" {
    esh_execute_for_each_four_args assert_four_arguments "foo" "bar" "baz" "qux" "foo" "bar" "baz" "qux" "foo" "bar" "baz" "qux"
    assert_equal "$function_call_count" 3
}

@test "execute for each five arguments" {
    esh_execute_for_each_five_args assert_five_arguments "foo" "bar" "baz" "qux" "quux" "foo" "bar" "baz" "qux" "quux" "foo" "bar" "baz" "qux" "quux"
    assert_equal "$function_call_count" 3
}

@test "execute for each six arguments" {
    esh_execute_for_each_six_args assert_six_arguments "foo" "bar" "baz" "qux" "quux" "quuz" "foo" "bar" "baz" "qux" "quux" "quuz" "foo" "bar" "baz" "qux" "quux" "quuz"
    assert_equal "$function_call_count" 3
}
