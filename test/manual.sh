#!/bin/bash

source essenshell.sh

echo "--- Variables ---"

echo Version: $ESH_VERSION
echo -e ${ESH_BLACK}BLACK${ESH_CLEAR} CLEAR
echo -e ${ESH_RED}RED${ESH_CLEAR} CLEAR
echo -e ${ESH_GREEN}GREEN${ESH_CLEAR} CLEAR
echo -e ${ESH_YELLOW}YELLOW${ESH_CLEAR} CLEAR
echo -e ${ESH_BLUE}BLUE${ESH_CLEAR} CLEAR
echo -e ${ESH_MAGENTA}MAGENTA${ESH_CLEAR} CLEAR
echo -e ${ESH_CYAN}CYAN${ESH_CLEAR} CLEAR
echo -e ${ESH_WHITE}WHITE${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_BLACK}BRIGHT BLACK${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_RED}BRIGHT RED${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_GREEN}BRIGHT GREEN${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_YELLOW}BRIGHT YELLOW${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_BLUE}BRIGHT BLUE${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_MAGENTA}BRIGHT MAGENTA${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_CYAN}BRIGHT CYAN${ESH_CLEAR} CLEAR
echo -e ${ESH_BRIGHT_WHITE}BRIGHT WHITE${ESH_CLEAR} CLEAR

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

esh_set_app_color $ESH_BLACK
esh_print_info "info with app name in black"
esh_print_warning "warning with app name in black"
esh_print_error "error with app name in black"
esh_print_debug "debug with app name in black"

esh_set_app_color $ESH_RED
esh_print_info "info with app name in red"
esh_set_app_color $ESH_GREEN
esh_print_info "info with app name in green"
esh_set_app_color $ESH_YELLOW
esh_print_info "info with app name in yellow"
esh_set_app_color $ESH_BLUE
esh_print_info "info with app name in blue"
esh_set_app_color $ESH_MAGENTA
esh_print_info "info with app name in magenta"
esh_set_app_color $ESH_CYAN
esh_print_info "info with app name in cyan"
esh_set_app_color $ESH_BRIGHT_BLACK
esh_print_info "info with app name in bright black"
esh_set_app_color $ESH_BRIGHT_RED
esh_print_info "info with app name in bright red"
esh_set_app_color $ESH_BRIGHT_GREEN
esh_print_info "info with app name in bright green"
esh_set_app_color $ESH_BRIGHT_YELLOW
esh_print_info "info with app name in bright yellow"
esh_set_app_color $ESH_BRIGHT_BLUE
esh_print_info "info with app name in bright blue"
esh_set_app_color $ESH_BRIGHT_MAGENTA
esh_print_info "info with app name in bright magenta"
esh_set_app_color $ESH_BRIGHT_CYAN
esh_print_info "info with app name in bright cyan"
esh_set_app_color $ESH_BRIGHT_WHITE
esh_print_info "info with app name in bright white"

esh_set_app_color $ESH_BOLD_BLACK
esh_print_info "info with app name in bold black"
esh_set_app_color $ESH_BOLD_RED
esh_print_info "info with app name in bold red"
esh_set_app_color $ESH_BOLD_GREEN
esh_print_info "info with app name in bold green"
esh_set_app_color $ESH_BOLD_YELLOW
esh_print_info "info with app name in bold yellow"
esh_set_app_color $ESH_BOLD_BLUE
esh_print_info "info with app name in bold blue"
esh_set_app_color $ESH_BOLD_MAGENTA
esh_print_info "info with app name in bold magenta"
esh_set_app_color $ESH_BOLD_CYAN
esh_print_info "info with app name in bold cyan"
esh_set_app_color $ESH_BOLD_BRIGHT_BLACK
esh_print_info "info with app name in bold bright black"
esh_set_app_color $ESH_BOLD_BRIGHT_RED
esh_print_info "info with app name in bold bright red"
esh_set_app_color $ESH_BOLD_BRIGHT_GREEN
esh_print_info "info with app name in bold bright green"
esh_set_app_color $ESH_BOLD_BRIGHT_YELLOW
esh_print_info "info with app name in bold bright yellow"
esh_set_app_color $ESH_BOLD_BRIGHT_BLUE
esh_print_info "info with app name in bold bright blue"
esh_set_app_color $ESH_BOLD_BRIGHT_MAGENTA
esh_print_info "info with app name in bold bright magenta"
esh_set_app_color $ESH_BOLD_BRIGHT_CYAN
esh_print_info "info with app name in bold bright cyan"
esh_set_app_color $ESH_BOLD_BRIGHT_WHITE
esh_print_info "info with app name in bold bright white"
