#!/usr/bin/env bash

# Unit test runner for bats

[ -z $BATS_LIB_PATH ] && export BATS_LIB_PATH="/usr/local/lib"

test_dir=$(dirname $(realpath $0))

$test_dir/common.bats
