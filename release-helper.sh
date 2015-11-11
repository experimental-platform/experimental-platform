#!/usr/bin/env bash
set -e

CHANNEL=${1:-alpha}

function main() {
    available_channels="development alpha"
    if [[ ! ${available_channels} =~ ${CHANNEL} ]]; then
        echo "INVALID channel '${CHANNEL}'"
        exit 23
    fi

    if [[ "${CHANNEL}" == "development" ]]; then
        CHANNEL="alpha"
        PRODUCT_CHANNEL="development"
    else
        PRODUCT_CHANNEL="master"
    fi
    echo "Working on out release channel ${CHANNEL} and product channel ${PRODUCT_CHANNEL}"
    echo -e "\n\n\nEXPERIMENTAL-PLATFORM: ${CHANNEL}\n\n"
    git checkout ${CHANNEL}
    git pull
    git submodule update --init
    git submodule foreach git fetch --all
    echo -e "\n\n\nEVERYTHING ELSE: ${PRODUCT_CHANNEL}\n\n"
    git submodule foreach git checkout ${PRODUCT_CHANNEL}
    cd platform-ubuntu; git checkout latest; cd ..
    cd platform-buildstep; git checkout herokuish; cd ..
    git submodule foreach git pull

    echo "ALL REPOSITORIES UPDATED. PLEASE REVIEW, COMMIT AND PUSH NOW."
}


main
