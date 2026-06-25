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

source ./scripts/sources/base-layer-list

NEW_VERSION=$1
VERSION_BASE_DIR="./layers/${NEW_VERSION}"

if ! [ -d "${VERSION_BASE_DIR}" ]; then
    echo "Creating new version directory: ${VERSION_BASE_DIR}"
    mkdir -p "${VERSION_BASE_DIR}"
else
    echo "Version directory already exists: ${VERSION_BASE_DIR}"
fi


for LAYER in "${!LAYER_LIST[@]}"; do
    LAYER_URL="${LAYER_LIST[$LAYER]}"
    LAYER_DIR="${VERSION_BASE_DIR}/${LAYER}"

    BRANCHES=$(git ls-remote --heads "${LAYER_URL}" | awk '{print $2}' | sed 's/refs\/heads\///')

    echo "${BRANCHES}" | grep ${NEW_VERSION} || echo "No matching branch found for ${NEW_VERSION}"

    if [[ ! " ${BRANCHES[@]} " =~ " ${NEW_VERSION} " ]]; then
        echo "Branch ${NEW_VERSION} does not exist for ${LAYER}. Setting to master."
        NEW_VERSION="master"
    fi

    if ! [ -d "${LAYER_DIR}" ]; then
        echo "Cloning ${LAYER} from ${LAYER_URL} into ${LAYER_DIR}"
        echo "git clone -b \"${NEW_VERSION}\" \"${LAYER_URL}\" \"${VERSION_BASE_DIR}/${LAYER}\""
    else
        echo "Layer directory already exists: ${LAYER_DIR}"
    fi

    # Change to the layer directory and fetch the latest changes
    #pushd "${LAYER_DIR}" > /dev/null
    echo git fetch --all
    echo git checkout "${NEW_VERSION}"
    echo git pull origin "${NEW_VERSION}"
    #popd > /dev/null
done