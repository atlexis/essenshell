# `files.sh` documentation

- Included with `source "$ESSENSHELL_PATH/files.sh"`

## Functions
- [`esh_assert_file_exist`](#esh_assert_file_exist) - Assert that file exist
- [`esh_assert_file_not_exist`](#esh_assert_file_not_exist) - Assert that file does not exist
- [`esh_assert_regular_file_exist`](#esh_assert_regular_file_exist) - Assert that provided file exist and is a regular file
- [`esh_assert_directory_exist`](#esh_assert_directory_exist) - Assert that provided file exist and is a directory
- [`esh_assert_symlink_exist`](#esh_assert_symlink_exist) - Assert that provided file exist and is a symbolic link
- [`esh_copy_file`](#esh_copy_file) - Copy file or directory recursively from source file to destination file
- [`esh_symlink_file`](#esh_symlink_file) - Create symbolic link from source file to destination file
- [`esh_remove_symlink`](#esh_remove_symlink) - Remove symbolic link
- [`esh_replace_symlink`](#esh_replace_symlink) - Create or replace symbolic link from destination file to source file.

### `esh_assert_file_exist`
- Syntax: `esh_assert_file_exist <PATH>`
- Assert that file exist
- Does not resolve symbolic links, but asserts that something exist at the file path.
- `$1` (`<PATH>`) : path to file
- Return code:
    - **0** : file was found
    - **93** : exit code, file was not found

### `esh_assert_file_not_exist`
- Syntax: `esh_assert_file_not_exist <PATH>`
- Assert that file does not exist
- Does not resolve symbolic links, but asserts that nothing exist at the file path.
- `$1` (`<PATH>`) : path to file
- Return code:
    - **0** : file was not found
    - **93** : exit code, file was found

### `esh_assert_regular_file_exist`
- Syntax: `esh_assert_regular_file_exist <PATH>`
- Assert that provided file exist and is a regular file
- Will exit with an error code if the provided path is a symbolic link, not try to resolve it.
- `$1` (`<PATH>`) : path to regular file
- Return code:
    - **0** : file is found and is a regular file
    - **93** : exit code, file was not found
    - **93** : exit code, file was not a regular file

### `esh_assert_directory_exist`
- Syntax: `esh_assert_directory_exist <PATH>`
- Assert that provided file exist and is a directory
- Will exit with an error code if the provided path is a symbolic link, not try to resolve it.
- `$1` (`<PATH>`) : path to directory
- Return code:
    - **0** : file is found and is a directory
    - **93** : exit code, file was not found
    - **93** : exit code, file was not a directory

### `esh_assert_symlink_exist`
- Syntax: `esh_assert_symlink_exist <PATH>`
- Assert that provided file exist and is a symbolic link
- `$1` (`<PATH>`) : path to symbolic link
- Return codes:
    - **0** : file is found and is a symbolic link
    - **93** : exit code, file was not found
    - **93** : exit code, file was not a symbolic link

### `esh_copy_file`
- Syntax: `esh_copy_file <SRC> [<DEST>]`
- Copy file or directory recursively from source file to destination file
- `$SOURCE_DIR` : directory to create source file path from
- `$DEST_DIR` : directory to create destination file path form
- `$1` (`<SRC>`) : path to source file, relative from `$SOURCE_DIR`.
- `$2` (`<DEST>`) : **optional**, path to destination file, relative from `$DEST_DIR`, will be same as `$1` if omitted.
- Return codes:
    - **0** : successful copy
    - **2** : source file does not exist
    - **3** : exit code, mandatory positional argument was not provided
    - **4** : exit code, mandatory environment variable was not provided
    - **93** : exit code, destination file already exist

### `esh_symlink_file`
- Syntax: `esh_symlink_file <SRC> [<DEST>]`
- Create symbolic link from source file to destination file
- `$SOURCE_DIR` : directory to create source file path from
- `$DEST_DIR` : directory to create destination file path from
- `$1` (`<SRC>`) : path to source file, relative from `$SOURCE_DIR`
- `$2` (`<DEST>`) : **optional**, path to destination file, relative from `$DEST_DIR`, will be same as `$1` if omitted
-  Return codes:
    - **0** : successful symbolic link
    - **3** : exit code, mandatory positional argument was not provided
    - **4** : exit code, mandatory environment variable was not provided
    - **93** : exit code, source file does not exist
    - **93** : exit code, destination file already exist

### `esh_remove_symlink`
- Syntax: `esh_remove_symlink <LINK>`
- Remove symbolic link
-  `$DEST_DIR` : directory to create symbolic link file path from
- `$1` : path to symbolic link file, relative from `$DEST_DIR`
- Return codes:
    - **0** : successful removal of symbolic link
    - **3** : exit code, mandatory positional argument was not provided
    - **4** : exit code, mandatory environment variable was not provided
    - **93** : exit code, file was not found
    - **93** : exit code, file was not a symbolic link

### `esh_replace_symlink`
- Syntax: `esh_replace_symlink <SRC> [<DEST>]`
- Create or replace symbolic link from destination file to source file.
- Ask for confirmation before removing an existing symbolic link.
- Will skip symbolic links already pointing to the wanted source file.
- `$SOURCE_DIR` : directory to create source file path from
- `$DEST_DIR` : directory to create destination file path from
- `$1` (`<SRC>`) : path to source file, relative from `$SOURCE_DIR`
- `$2` (`<DEST>`) : **optional**, path to destination file, relative from `$DEST_DIR`, will be same as $1 if omitted
- Return codes:
    - **0** : successful symbolic link
    - **1** : user declined removing symbolic link
    - **2** : unknown answer after prompt
    - **3** : exit code, mandatory positional argument was not provided
    - **4** : exit code, mandatory environment variable was not provided
    - **93** : exit code, source file does not exist
