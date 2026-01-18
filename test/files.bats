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

@test "copy file, missing SOURCE_DIR" {
    run esh_copy_file
    assert_failure 4
}

@test "copy file, missing DEST_DIR" {
    SOURCE_DIR="/files/source/"
    run esh_copy_file
    assert_failure 4
}

@test "copy file, missing path to source file" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    run esh_copy_file
    assert_failure 3
}

@test "copy file, source file does not exist" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    run esh_copy_file "myfile"
    assert_failure 2
}

@test "copy file, destination file does already exist" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    touch "$SOURCE_DIR/myfile"
    touch "$DEST_DIR/myfile"

    run esh_copy_file "myfile"

    assert_failure 93
}

@test "copy file" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    echo "foo bar baz" > "$SOURCE_DIR/myfile"
    assert_not_exists "$DEST_DIR/myfile"

    run esh_copy_file "myfile"

    assert_success
    assert_file_exists "$DEST_DIR/myfile"
    assert_files_equal "$SOURCE_DIR/myfile" "$DEST_DIR/myfile"
}

@test "copy file, different destination file name" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    echo "foo bar baz" > "$SOURCE_DIR/myfile"
    assert_not_exists "$DEST_DIR/mydestination"

    run esh_copy_file "myfile" "mydestination"

    assert_success
    assert_file_exists "$DEST_DIR/mydestination"
    assert_file_not_exists "$DEST_DIR/myfile"
    assert_files_equal "$SOURCE_DIR/myfile" "$DEST_DIR/mydestination"
}

@test "copy file, source and destination in nested directories" {
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    mkdir -p "$SOURCE_DIR/path/to/dir/"
    assert_not_exists "$DEST_DIR/another/path/to/mydestination"

    run esh_copy_file "path/to/dir" "another/path/to/mydestination"

    assert_success
    assert_dir_exists "$DEST_DIR/another/path/to/mydestination"
}

@test "copy file, recursive copy of source file directory" {
    SOURCE_DIR=/files/source/
    DEST_DIR="/files/dest/"
    mkdir -p "$SOURCE_DIR/foo/bar" "$SOURCE_DIR/foo/baz" "$SOURCE_DIR/foo/bla/bla"
    echo "foo bar baz" > "$SOURCE_DIR/foo/bla/myfile.txt"

    run esh_copy_file "foo" "base/foo"

    assert_success
    assert_dir_exists "$DEST_DIR/base/foo"
    assert_dir_exists "$DEST_DIR/base/foo/bar"
    assert_dir_exists "$DEST_DIR/base/foo/baz"
    assert_dir_exists "$DEST_DIR/base/foo/bla"
    assert_dir_exists "$DEST_DIR/base/foo/bla/bla"
    assert_file_exists "$DEST_DIR/base/foo/bla/myfile.txt"
    assert_files_equal "$SOURCE_DIR/foo/bla/myfile.txt" "$DEST_DIR/base/foo/bla/myfile.txt"
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

@test "remove symlink, missing DEST_DIR" {
    run esh_remove_symlink
    assert_failure 4
}

@test "remove symlink, missing path to file to remove" {
    DEST_DIR=/files/dest/
    run esh_remove_symlink
    assert_failure 3
}

@test "remove symlink, file to remove does not exist" {
    DEST_DIR=/files/dest/
    run esh_remove_symlink "myfile"
    assert_failure 93
}

@test "remove symlink, file to remove is not a symlink" {
    DEST_DIR=/files/dest/
    touch "$DEST_DIR/myfile"

    run esh_remove_symlink "myfile"

    assert_failure 93
}

@test "remove symlink" {
    DEST_DIR=/files/dest/
    ln -s "/files/source/file" "$DEST_DIR/mylink"
    assert_link_exists "$DEST_DIR/mylink"

    run esh_remove_symlink "mylink"

    assert_success
    assert_link_not_exists "$DEST_DIR/mylink"
}

@test "install with unknown action" {
    ESH_INSTALL="foobar"
    run esh_install
    assert_failure 93
}

@test "install with no action" {
    # successful symlink file
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    touch "$SOURCE_DIR/myfile"
    assert_link_not_exists "$DEST_DIR/myfile"

    run esh_install "myfile"

    assert_success
    assert_link_exists "$DEST_DIR/myfile"
}

@test "install with install action" {
    ESH_INSTALL="install"
    # successful symlink file
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    touch "$SOURCE_DIR/myfile"
    assert_link_not_exists "$DEST_DIR/anotherfile"

    run esh_install "myfile" "anotherfile"

    assert_success
    assert_link_exists "$DEST_DIR/anotherfile"
}

@test "install with install_symlink action" {
    ESH_INSTALL="install_symlink"
    # successful symlink file
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    mkdir -p "$SOURCE_DIR/path/to/myfile"
    assert_link_not_exists "$DEST_DIR/path/to/myfile"

    run esh_install "path/to/myfile"

    assert_success
    assert_link_exists "$DEST_DIR/path/to/myfile"
}

@test "install with install_copy action" {
    ESH_INSTALL="install_copy"
    # successful copy file
    SOURCE_DIR="/files/source/"
    DEST_DIR="/files/dest/"
    echo "foo bar baz" > "$SOURCE_DIR/myfile"
    assert_not_exists "$DEST_DIR/myfile"

    run esh_install "myfile"

    assert_success
    assert_file_exists "$DEST_DIR/myfile"
    assert_files_equal "$SOURCE_DIR/myfile" "$DEST_DIR/myfile"
}

@test "install with uninstall action" {
    ESH_INSTALL="uninstall"
    # successful remove symlink
    DEST_DIR=/files/dest/
    ln -s "/files/source/file" "$DEST_DIR/mylink"
    assert_link_exists "$DEST_DIR/mylink"

    run esh_install "mylink"

    assert_success
    assert_link_not_exists "$DEST_DIR/mylink"
}

@test "install with uninstall_symlink action" {
    ESH_INSTALL="uninstall_symlink"
    # successful remove symlink
    DEST_DIR=/files/dest/
    mkdir -p "$DEST_DIR/path/to"
    ln -s "/files/source/file" "$DEST_DIR/path/to/mylink"
    assert_link_exists "$DEST_DIR/path/to/mylink"

    run esh_install "path/to/mylink"

    assert_success
    assert_link_not_exists "$DEST_DIR/path/to/mylink"
    assert_dir_exists "$DEST_DIR/path/to"
}
