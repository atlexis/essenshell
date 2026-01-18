if [[ -z "${ESSENSHELL_PATH-}" ]]; then
    echo "Environment variable ESSENSHELL_PATH not set."
    exit 1
fi

source "$ESSENSHELL_PATH/misc.sh"
source "$ESSENSHELL_PATH/print.sh"
source "$ESSENSHELL_PATH/files.sh"
source "$ESSENSHELL_PATH/variables.sh"
source "$ESSENSHELL_PATH/functions.sh"
source "$ESSENSHELL_PATH/input.sh"
