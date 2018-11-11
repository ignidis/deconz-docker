#!/bin/bash
#
# docker build deconz image
# Usage:
#        [sudo] build.sh <deconz-version>
#
# Must run as superuser, either you are root or must sudo 
#
docker build --build-arg DECONZ_VERSION="$1" --build-arg DECONZ_SVC_NAME="deconz" --build-arg DECONZ_SVC_UID="9001" -t deconz:"$1"-arm32v7-debian .
