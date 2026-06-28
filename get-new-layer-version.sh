#!/usr/bin/env bash

# This script will get the latest setup of the listed Yocto layers,
# then will create a new directory for that version (if needed) and 
# then clone all of the layers into that directory if necessary, then
# setting those layers to the correct version.
#
# This is useful for creating a new Yocto build version while keeping old versions intact.

set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <new_version>"
    exit 1
fi

source scripts/sources/base-layer-list

NEW_VERSION=$1
BASE_LAYERS_DIR="layers"

if ! [ -d "${BASE_LAYERS_DIR}" ]; then
    echo "Creating new version directory: ${BASE_LAYERS_DIR}"
    mkdir -p "${BASE_LAYERS_DIR}"
else
    echo "Version directory already exists: ${BASE_LAYERS_DIR}"
fi

USER_VERSION=${NEW_VERSION}

for LAYER in "${!LAYER_LIST[@]}"; do
    LAYER_URL="${LAYER_LIST[$LAYER]}"
    LAYER_DIR="${BASE_LAYERS_DIR}/${LAYER}"

    NEW_VERSION=${USER_VERSION}

    #echo "Looking for ${NEW_VERSION} branch for ${LAYER} at ${LAYER_URL}"

    BRANCHES=()
    while IFS= read -r line; do
        BRANCHES+=("$line")
    done < <(git ls-remote --heads "${LAYER_URL}" --h --sort origin "refs/heads/*" | awk -F'/' '{print $3}')

    if [[ ! " ${BRANCHES[@]} " =~ " ${NEW_VERSION} " ]]; then
        #echo "Branch ${NEW_VERSION} does not exist for ${LAYER}. Setting to master."
        NEW_VERSION="master"
    fi

    echo "Cheking for $(dirname "${LAYER_DIR}")"

    if ! [ -d "$(dirname "${LAYER_DIR}")" ]; then
        echo "Creating directory for layer: $(dirname "${LAYER_DIR}")"
        mkdir -p "$(dirname "${LAYER_DIR}")"
    else
        echo "Directory for layer already exists: $(dirname "${LAYER_DIR}")"
    fi
    
    if ! [ -d "${LAYER_DIR}" ]; then
        echo "Cloning submodule ${LAYER} branch ${NEW_VERSION} from ${LAYER_URL} into ${LAYER_DIR}"
        git submodule add --force -b "${NEW_VERSION}" "${LAYER_URL}" "${LAYER_DIR}"
    else
        git submodule update --init "${LAYER_DIR}"
        echo "Layer directory already exists: ${LAYER_DIR}"
    fi
done

echo "Done"