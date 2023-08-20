#!/bin/bash

source essenshell.sh

echo "--- Variables ---"

echo Version: $ESH_VERSION
echo -e ${ESH_COLOR_GREEN}GREEN${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_YELLOW}YELLOW${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_RED}RED${ESH_CLEAR} CLEAR

echo
echo "--- Functions ---"

esh_version
esh_print_info "info test"
esh_print_warning "warning test"
esh_print_error "error test"
