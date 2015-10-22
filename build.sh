#!/usr/bin/env bash
set -e

DEBUG=/bin/false

${DEBUG} && set -x
${DEBUG} && echo "\n\nALL VARIABLES:\n"
${DEBUG} && set
${DEBUG} && echo "ALL VARIABLES DONE\n\n"

# TODO: does build but not use the built "ubuntu" :(

CHANNEL=${TRAVIS_BRANCH}

function push_image() {
    local i=0
    local image=$1
    while true; do
        docker push ${image} > /dev/stderr | true
        if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
            break
        fi
        if [[ ${i} -gt 10 ]]; then
            echo -e "\n\n\nERROR: Couldn't push ${image}\n"
            exit 23
        fi
        i=$[$i+1]
        echo -e "Sleeping 15 seconds."
        sleep 15;
    done
}

function build_image() {
    local j=0
    local docker_tag=$1
    local docker_dir=$2
    while true; do
        echo -e "\nBuilding Image ${docker_tag}, round ${j}"
        docker build -t ${docker_tag} ${docker_dir} > /dev/stderr | true
        if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
            break
        fi
        if [[ ${j} -gt 10 ]]; then
            echo -e "\n\n\nERROR: Couldn't build ${docker_tag}\n"
            exit 23
        fi
        j=$[$j+1]
        echo -e "Sleeping 15 seconds."
        sleep 15;
    done
}

if [[ -z ${CHANNEL+x} ]]; then
    echo "CHANNEL not set, exiting."
    exit 23
elif [[ -z "$DEPLOY" ]]; then
    echo "PREPARING ${CHANNEL} FOR TEST"
    export VERSION=${CHANNEL}-testing
    for repo in platform-*; do
        if [[ -f ./${repo}/Dockerfile ]]; then
            NAME=${repo#platform-}
            echo -e "\n\n\nBUILDING ${NAME}:${VERSION}\n"
            cd ${repo}
            [ -x ./ci-build.sh ] && ./ci-build.sh || true
            build_image experimentalplatform/${NAME}:${VERSION} .
            #if [[ "$NAME" == "configure" ]]; then
            #    echo -e "\n\n\nComponent platform-configure detected, counting occurrances of the word 'testing'..."
            #    UNITCOUNT=$(docker run -ti --rm experimentalplatform/configure:${VERSION} bash -c 'grep -l testing /services/*-protonet.service | wc -l')
            #    echo -e "Assertion: There are these many systemd units that contain the word 'testing': ${UNITCOUNT}\n\n"
            #fi
            echo -e "\n\n\nDEPLOYING ${NAME}:${VERSION}\n"
            push_image experimentalplatform/${NAME}:${VERSION}
            cd ..
        fi
    done
    echo -e "\n\nCHANNEL ${VERSION} BUILT!\n"
else
    echo "DEPLOYING ${CHANNEL}"
    export VERSION=${CHANNEL}
    for repo in platform-*; do
        if [[ -f ./${repo}/Dockerfile ]]; then
            NAME=${repo#platform-}
            if [[ "$NAME" == "configure" ]]; then
                echo "Not retagging configure"
            else
                echo -e "\n\n\nRETAGGING $NAME:${VERSION}\n"
                docker tag -f experimentalplatform/${NAME}:${VERSION}-testing experimentalplatform/${NAME}:${VERSION}
                push_image experimentalplatform/${NAME}:${VERSION}
            fi
        fi
    done
    # TODO: in five years when we're all fat, rich and have lots of time: refactor this into a function
    cd platform-configure
    [ -x ./ci-build.sh ] && ./ci-build.sh || true
    echo -e "\n\nBUILDING experimentalplatform/configure:${VERSION}\n"
    build_image experimentalplatform/configure:${VERSION} .
    echo "Assertion: None of the systemd units may have the word 'testing' in it."
    [[ $(docker run -ti --rm experimentalplatform/configure:${VERSION} bash -c 'grep -l testing /services/*-protonet.service | wc -l') =~ 0 ]]
    echo -e "\n\nDEPLOYING experimentalplatform/configure:${VERSION}\n"
    push_image experimentalplatform/configure:${VERSION}
    echo -e "\n\nCHANNEL ${VERSION} RELEASED!\n"
fi
