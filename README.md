# Essenshell

Essenshell is a shell library containing the most common and essential functions.

## Installation
- Run `./install.sh` to install files on the system.
- Requires `ESSENSHELL_PATH` environment variable to be set
    - `ESSENSHELL_PATH="$PWD" ./install.sh` - install with `essenshell`-files from current working directory
- Installation directory is determined in following priority order:
    1. First positional argument `./install.sh /Path/To/Install/essenshell-0.1`
    2. Default directory, `$HOME/.local/opt/essenshell-<VERSION>`: `./install.sh`

## Usage
- Environment variable `"ESSENSHELL_PATH"` must be set before anything is sourced.
    - The directory where `essenshell/` is installed on the system.
    - E.g. `ESSENSHELL_PATH="$HOME/.local/lib/essenshell"`
- Copy a [template](#templates) into a user script to get up and running quickly
- Complete library: [`essenshell.sh`](#global)
- Sub-libraries:
    - [`files.sh`](/docs/files.md) - file-related functions
    - [`functions.sh`](/docs/functions.md) - function-related functions
    - [`input.sh`](/docs/input.md) - user-input-related functions
    - [`print.sh`](/docs/print.md) - print-related functions
    - [`variables.sh`](/docs/variables.md) - variable-related functions
- **Note**: Sourced variables and functions beginning with an underscore are private variables and are only intended for internal use, do not rely on these directly since their APIs are not stable and might change at any time.

### Templates
- Copy the content of any template file into your user script
- _Neovim_ example: `:read $ESSENSHELL_PATH/templates/verify_essenshell_path`
- `templates/verify_essenshell_path`
    - verify that `ESSENSHELL_PATH` environment variable is set
    - fallback and try default path if not, `$HOME/.local/lib/essenshell`
    - verify that `$ESSENSHELL_PATH/essenshell.sh` is available
    - source `$ESSENSHELL_PATH/essenshell.sh` into script
- `templates/simple_essenshell_path`
    - verify that `$ESSENSHELL_PATH/essenshell.sh` exist
    - source `$ESSENSHELL_PATH/essenshell.sh` into script

### Global
- Included with `source essenshell.sh`
- Variables:
    - `ESSENSHELL_VERSION` - current version of essenshell
- Functions:
- `esh_version` - print version of essenshell
- Includes all sub-libraries

## Test
- Dependencies: `docker`
- `docker build -t essenshell .` - build Docker image, only once
- `docker run -v $(pwd):/app:ro essenshell bats test` - run unit tests in Docker container
- `docker run -v $(pwd):/app essenshell bashcov -- bats test` - run unit test and code coverage in Docker container
    - open `coverage/index.html` in browser to see results
- Convenience scripts:
    - `test/manual.sh` - run tests with output for manual verification
- `.simplecov` - configuration for coverage test
