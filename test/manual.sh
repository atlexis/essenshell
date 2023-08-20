#!/bin/bash

source essenshell.sh

echo "--- Variables ---"

echo Version: $ESH_VERSION
echo -e ${ESH_COLOR_BLACK}BLACK${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_RED}RED${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_GREEN}GREEN${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_YELLOW}YELLOW${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_BLUE}BLUE${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_MAGENTA}MAGENTA${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_CYAN}CYAN${ESH_CLEAR} CLEAR
echo -e ${ESH_COLOR_WHITE}WHITE${ESH_CLEAR} CLEAR

echo
echo "--- Functions ---"

esh_version
esh_print_info "info test"
esh_print_warning "warning test"
esh_print_error "error test"

esh_print_debug "only seen when running with 'env ESH_DEBUG=true ./manual.sh'"
ESH_DEBUG=true
esh_print_debug "esh_debug test"

esh_set_app_name "MANUAL"
esh_print_info "info with app name"
esh_print_warning "warning with app name"
esh_print_error "error with app name"
esh_print_debug "debug with app name"

esh_set_app_color $ESH_COLOR_BLACK
esh_print_info "info with app name in black"
esh_print_warning "warning with app name in black"
esh_print_error "error with app name in black"
esh_print_debug "debug with app name in black"

esh_set_app_color $ESH_COLOR_RED
esh_print_info "info with app name in red"
esh_set_app_color $ESH_COLOR_GREEN
esh_print_info "info with app name in green"
esh_set_app_color $ESH_COLOR_YELLOW
esh_print_info "info with app name in yellow"
esh_set_app_color $ESH_COLOR_BLUE
esh_print_info "info with app name in blue"
esh_set_app_color $ESH_COLOR_MAGENTA
esh_print_info "info with app name in magenta"
esh_set_app_color $ESH_COLOR_CYAN
esh_print_info "info with app name in cyan"
esh_set_app_color $ESH_COLOR_WHITE
esh_print_info "info with app name in white"
