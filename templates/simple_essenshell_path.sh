essenshell_file="$ESSENSHELL_PATH/essenshell.sh"
[[ ! -e "$essenshell_file" ]] && echo "File not found: $essenshell_file" && exit 1
source "$essenshell_file"
