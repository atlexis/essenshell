# Essenshell

Essenshell is a shell library containing the most common and essential functions.

## Usage
- `source essenshell.sh` - include and start using the library in a script.
- `ESH_VERSION` - variable holding version of essenshell
- `esh_version` - function printing version of essenshell

## Test
- Dependencies: `bats-core`, `bats-support`, and `bats-assert`
- `bats` binary must be in path
- `bats-support`, and `bats-assert` must be in directory specified by `BATS_LIB_PATH`, or in `/usr/local/lib`
- `test/ut.sh` - run unit tests
