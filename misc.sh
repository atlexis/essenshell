[[ -n "${_ESH_MISC_LOADED-}" ]] && return
_ESH_MISC_LOADED=true

ESSENSHELL_VERSION="0.1.0"

function esh_version {
    echo "$ESSENSHELL_VERSION"
}
