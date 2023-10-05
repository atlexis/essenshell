#!/usr/bin/env bash

ut_command="bats test"

docker build -t essenshell .
docker run essenshell bash -c "$ut_command"
