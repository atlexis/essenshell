if [[ -z "${ESSENSHELL_PATH-}" ]]; then
    echo "Environment variable ESSENSHELL_PATH not set."
    exit 1
fi

ESSENSHELL_VERSION="0.1.0"

function esh_version {
    echo "$ESSENSHELL_VERSION"
}

source "$ESSENSHELL_PATH/print.sh"
source "$ESSENSHELL_PATH/files.sh"
source "$ESSENSHELL_PATH/variables.sh"
source "$ESSENSHELL_PATH/functions.sh"
