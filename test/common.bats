function setup {
    bats_load_library bats-support
    bats_load_library bats-assert

    source "$ESSENSHELL_PATH/essenshell.sh"
}

@test "ESSENSHELL_PATH not set" {
    essenshell_file="$ESSENSHELL_PATH/essenshell.sh"
    unset "ESSENSHELL_PATH"
    run source "$essenshell_file"
    assert_failure 1
}
