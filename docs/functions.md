# `functions.sh` documentation

- Included with `source "$ESSENSHELL_PATH/functions.sh"`

## Functions
- [`esh_assert_function_exist`](#esh_assert_function_exist) - Assert that function exist
- [`esh_execution_for_each_n_args`](#esh_execution_for_each_n_args) - Execute function with every chunk of provided number of arguments
- [`esh_execution_for_each_arg`](#esh_execution_for_each_arg) - Execute function with every provided argument
- [`esh_execution_for_each_two_args`](#esh_execution_for_each_two_args) - Execute function chunk of every two provided arguments
- [`esh_execution_for_each_three_args`](#esh_execution_for_each_two_args) - Execute function chunk of every three provided arguments
- [`esh_execution_for_each_four_args`](#esh_execution_for_each_two_args) - Execute function chunk of every four provided arguments
- [`esh_execution_for_each_five_args`](#esh_execution_for_each_two_args) - Execute function chunk of every five provided arguments
- [`esh_execution_for_each_six_args`](#esh_execution_for_each_two_args) - Execute function chunk of every six provided arguments

### `esh_assert_function_exist`
- Syntax: `esh_assert_function_exist <NAME>`
- Assert that function exist
- `$1` : function name
- Return code:
    - **0** : function was found
    - **93** : exit code, function was not found

### `esh_execution_for_each_n_args`
- Syntax: `esh_execution_for_each_n_args <FUNC_NAME> <NUM_ARGS> [<ARG>...]`
- Execute function with every chunk of provided number of arguments
- `$1` : string, name of function to execute
- `$2` : number, number of arguments to use for each invokation
- `$3+` : **optional**, list of arguments to provide to function invokations
- Return codes:
    - **0** : if all executions were successful
    - **93** : exit code, function with provided name was not found
    - **93** : exit code, number of arguments were not evenly divisible by provided number

### `esh_execution_for_each_arg`
- Syntax: `esh_execution_for_each_arg <FUNC_NAME> [<ARG>...]`
- Execute function with every provided argument
- `$1` : string, name of function to execute
- `$2+` : **optional**, list of arguments to provide to function invokations
- Return codes:
    - **0** : if all executions were successful
    - **93** : exit code, function with provided name was not found

### `esh_execution_for_each_two_args`
- Syntax: `esh_execution_for_each_two_args <FUNC_NAME> [<ARG>...]`
- Execute function chunk of every two provided arguments
- Variants:
    - `esh_execution_for_each_three_args` - three arguments
    - `esh_execution_for_each_four_args` - four arguments
    - `esh_execution_for_each_five_args` - five arguments
    - `esh_execution_for_each_six_args` - six arguments
- `$1` : string, name of function to execute
- `$2+` : **optional**, list of arguments to provide to function invokations
- Return codes:
    - **0** : if all executions were successful
    - **93** : exit code, function with provided name was not found
    - **93** : exit code, number of arguments were not evenly divisible by provided number

