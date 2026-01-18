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
