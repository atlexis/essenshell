function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    local dir=$(dirname "$BATS_TEST_FILENAME")
    source ${dir}/../essenshell.sh
}

@test "correct version variable" {
    assert [ $ESSENSHELL_VERSION = 0.1.0 ]
}

@test "correct version function" {
    run esh_version
    assert_output "0.1.0"
}

@test "ESSENSHELL_PATH not set" {
    essenshell_file="$ESSENSHELL_PATH/essenshell.sh"
    unset "ESSENSHELL_PATH"
    run source "$essenshell_file"
    assert_failure 1
}
