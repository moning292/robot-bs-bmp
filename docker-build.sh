#!/usr/bin/env bash
#

set -xe

CONTEXT="`dirname $0`"

ROBOTBSBMP_VERSION="0.1"

docker build \
    "$@" \
    --build-arg ROBOTBSBMP_VERSION=${ROBOTBSBMP_VERSION} \
    -t "dockerregprod01.news.newslimited.local/chaichakanw/robot-bs-bmp:${ROBOTBSBMP_VERSION}" \
    -t "dockerregprod01.news.newslimited.local/chaichakanw/robot-bs-bmp:latest" \
    -t "dockerregprod01.news.newslimited.local/chaichakanw/robot-bs-bmp:stable" \
    -f "dockerfile" \
    "${CONTEXT}"

echo
read -p "Push images to the Docker registry [yN]? " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit
fi

docker push "dockerregprod01.news.newslimited.local/chaichakanw/robot-bs-bmp:${ROBOTBSBMP_VERSION}"
docker push "dockerregprod01.news.newslimited.local/chaichakanw/robot-bs-bmp:latest"
docker push "dockerregprod01.news.newslimited.local/chaichakanw/robot-bs-bmp:stable"

cat << INTRO
#================================================================================#

    Build finished. Yay!

#================================================================================#
INTRO