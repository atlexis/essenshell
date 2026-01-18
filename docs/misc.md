# `misc.sh` documentation

- Included with `source misc.sh`

## Variables
- `ESSENSHELL_VERSION` - current version of essenshell

## Functions
- `esh_version` - print version of essenshell
- [`esh_assert_number`](#esh_assert_number) - assert that input is a number, otherwise exit script

### `esh_assert_number`
- Syntax: `esh_assert_number <INPUT>`
- Assert that input is a number, otherwise exit script
- Only allows characters 0-9, i.e. 5.5, -5, and +7 are not considered numbers.
- `$1` (`<INPUT>`) : number, the input to assert whether it is a number
- Return codes:
    - **0** : input was a number
    - **93** : exit code, requested mandatory argument was not provided
    - **93** : exit code, provided input was not a number
