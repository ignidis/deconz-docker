#!/bin/bash
#
# docker build deconz image
# Usage:
#        [sudo] build.sh <deconz-version> <registry> <registry-user> <registry-pwd> <project>
#
# Must run as superuser, either you are root or must sudo 
#
docker build --build-arg NAME="DECONZ" --build-arg DECONZ_VERSION="$1" --build-arg DECONZ_SVC_NAME="deconz" --build-arg DECONZ_SVC_UID="9001" --rm -t builder:ml-deconz-arm32v7-debian --file ./Builderfile .
docker run --rm -it -d --name builder-deconz-arm32v7-debian builder:ml-deconz-arm32v7-debian bash && \
docker export builder-deconz-arm32v7-debian | docker import - builder:deconz-arm32v7-debian && \
docker kill builder-deconz-arm32v7-debian
docker build --build-arg NAME="DECONZ" --build-arg DECONZ_VERSION="$1" --build-arg DECONZ_SVC_NAME="deconz" --build-arg DECONZ_SVC_UID="9001" --rm -t "$2"/"$5"/deconz:"$1"-arm32v7-debian . && \
docker rmi builder:ml-deconz-arm32v7-debian builder:deconz-arm32v7-debian && \
docker login -p "$4" -u "$3" "$2" && \
docker push "$2"/"$5"/deconz:"$1"-arm32v7-debian && \
docker tag "$2"/"$5"/deconz:"$1"-arm32v7-debian deconz:"$1"-arm32v7-debian