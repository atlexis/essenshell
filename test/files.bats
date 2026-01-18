function setup {
    bats_load_library bats-support
    bats_load_library bats-assert
    bats_load_library bats-file

    source "$ESSENSHELL_PATH/files.sh"

    mkdir -p /files/source/
    mkdir -p /files/dest/
}

function teardown {
    rm -r /files/source/
    rm -r /files/dest/
}

@test "symlink file, missing SOURCE_DIR" {
    run esh_symlink_file
    assert_failure 4
}

@test "symlink file, missing DEST_DIR" {
    SOURCE_DIR="/files/source/"
    run esh_symlink_file
    assert_failure 4
}

@test "symlink file, missing path to source file" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    run esh_symlink_file
    assert_failure 3
}

@test "symlink file, source file does not exist" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    run esh_symlink_file "myfile"
    assert_failure 93
}

@test "symlink file, destination file does already exist" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    touch "$SOURCE_DIR/myfile"
    touch "$DEST_DIR/myfile"

    run esh_symlink_file "myfile"

    assert_failure 93
}

@test "symlink file" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    touch "$SOURCE_DIR/myfile"
    assert_link_not_exists "$DEST_DIR/myfile"

    run esh_symlink_file "myfile"

    assert_success
    assert_link_exists "$DEST_DIR/myfile"
}

@test "symlink file, different destination file name" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    touch "$SOURCE_DIR/myfile"
    assert_link_not_exists "$DEST_DIR/mydestination"

    run esh_symlink_file "myfile" "mydestination"

    assert_success
    assert_link_exists "$DEST_DIR/mydestination"
    assert_link_not_exists "$DEST_DIR/myfile"
}

@test "symlink file, source and destination in nested directories" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    mkdir -p "$SOURCE_DIR/path/to/dir/"
    assert_link_not_exists "$DEST_DIR/another/path/to/mydestination"

    run esh_symlink_file "path/to/dir" "another/path/to/mydestination"

    assert_success
    assert_link_exists "$DEST_DIR/another/path/to/mydestination"
}
