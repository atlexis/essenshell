# `variables.sh` documentation

- Included with `source "$ESSENSHELL_PATH/variables.sh"`

## Functions
- [`esh_mandatory_arg`](#esh_mandatory_arg) - Check if positional argument is provided, otherwise exit script
- [`esh_assign_mandatory_arg`](#esh_assign_mandatory_arg) - Try to assign positional argument to provided variable, or show error and exit script
- [`esh_assign_optional_arg`](#esh_assign_optional_arg) - Assign either positional argument or default value to provided variable
- [`esh_mandatory_env`](#esh_mandatory_env) - Check if environment variable is defined, otherwise exit script
- [`esh_assign_mandatory_env`](#esh_assign_mandatory_env) - Try to assign environment variable to provided variable, or show error and exit script
- [`esh_assign_optional_env`](#esh_assign_optional_env) - Assign either environment variable or default value to provided variable
- [`esh_args_divisible_by`](#esh_args_divisible_by) - Assert that number of arguments are evenly dividable by the divisor

### `esh_mandatory_arg`
- Syntax: `esh_mandatory_arg <ARGN> <ERRMSG> [<ARG>...]`
- Check if positional argument is provided, otherwise exit script
- `$1` (`<ARGN>`) : **number**, the position of the mandatory argument
- `$2` (`<ERRMSG>`) : error message to print if mandatory argument is missing
- `$3`+ (`<ARG>...`) : **optional**, list of arguments to check, commonly called with: `"$@"`
- Return codes:
    - **0** : argument sucessfully found
    - **1** : exit code, mandatory positional variables are unspecified
    - **2** : exit code, provided argument position was not a number
    - **3** : exit code, requested mandatory argument was not provided

### `esh_assign_mandatory_arg`
- Syntax: `esh_assign_mandatory_arg <ARGN> <VAR> <ERRMSG> [<ARG>...]`
- Try to assign positional argument to provided variable, or show error and exit script
- Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
- `$1` (`<ARGN>`) : **number**, the position of the mandatory argument
- `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
- `$3` (`<ERRMSG>`) : error message to print if mandatory argument is missing
- `$4`+ (`<ARG>...`) : **optional**, list of arguments to check, commonly called with: `"$@"`
- Return codes:
    - **0** : variable successfully assigned
    - **1** : exit code, mandatory positional variables are unspecified
    - **2** : exit code, provided argument position was not a number
    - **3** : exit code, requested mandatory argument was not provided

### `esh_assign_optional_arg`
- Syntax: `esh_assign_optional_arg <ARGN> <VAR> <DEFAULT> [<ARG>...]`
- Assign either positional argument or default value to provided variable
- Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
- `$1` (`<ARGN>`) : **number**, the position of the optional argument
- `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
- `$3` (`<DEFAULT>`) : default value to assign to variable
- `$4`+ (`<ARG>...`) : **optional**, list of arguments to check, commonly called with: `"$@"`
- Return codes:
    - **0** : variable successfully assigned
    - **1** : exit code, mandatory positional variables are unspecified
    - **2** : exit code, provided argument position was not a number

### `esh_mandatory_env`
- Syntax: `esh_mandatory_env <ENV_NAME>`
- Check if environment variable is defined, otherwise exit script
- `$1` : **string**, name of the environment variable to check
- Return codes:
    - **0** : environment variable is set
    - **1** : exit code, mandatory positional variables are unspecified
    - **4** : exit code, mandatory environment variable is undefined

### `esh_assign_mandatory_env`
- Syntax: `esh_assign_mandatory_env <ENV_NAME> <VAR>`
- Try to assign environment variable to provided variable, or show error and exit script
- Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
- `$1` (`<ENV_NAME>`) : **string**, name of the environment variable to assign from
- `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
- Return codes:
    - **0** : variable successfully assigned
    - **3** : exit code, requested mandatory arguments were not provided
    - **4** : exit code, mandatory environment variable is undefined

### `esh_assign_optional_env`
- Syntax: `esh_assign_optional_env <ENV_NAME> <VAR> <DEFAULT>`
- Assign either environment variable or default value to provided variable
- Do not assign to a variable name prefixed with `_esh`. Those names are reserved for internal use by essenshell and might result in errors due to variable scope clashes.
- `$1` (`<ENV_NAME>`) : **string**, name of the environment variable to assign from
- `$2` (`<VAR>`) : **variable**, name of the variable to assign resulting value to, see restrictions above
- `$3` (`<DEFAULT>`) : default value to assign to variable
- Return codes:
    - **0** : variable successfully assigned
    - **3** : exit code, requested mandatory arguments were not provided

### `esh_args_divisible_by`
- Syntax: `esh_args_divisible_by <DIVISOR> [<ARG>...]`
- Assert that number of arguments are evenly dividable by the divisor
- `$1` : number, divisor to be evenly dividable by
- `$2+` : optional, list of arguments to check, commonly called with: `"$@"`
- Return codes:
    - **0**: number of arguments are evenly dividable by the divisor
    - **93**: exit code, number of argument are not evenly dividable by the divisor
