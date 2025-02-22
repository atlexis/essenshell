DEFAULT_ESSENSHELL_PATH="$HOME/.local/lib/essenshell"

if [[ -z "$ESSENSHELL_PATH" ]]; then
    echo "Warning: ESSENSHELL_PATH is not set, trying default path: $DEFAULT_ESSENSHELL_PATH"
    ESSENSHELL_PATH="$DEFAULT_ESSENSHELL_PATH"
fi

essenshell_file="$ESSENSHELL_PATH/essenshell.sh" # Can be exchanged with a sub-library instead
if [[ ! -e "$essenshell_file" ]]; then
    echo "File not found: $essenshell_file"
    exit 1
fi

source "$essenshell_file"
