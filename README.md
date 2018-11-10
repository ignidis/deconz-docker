# deconz-docker
A docker image to run deCONZ on a Tinkerboard, using dresden-elektronik's raspbee or conbee.

This repository contains shell scripts and Dockerfiles that can be used to create a docker image to run deCONZ as docker container on an ASUS Tinkerboard.
The current image is based on arm32v7/debian:strecht-slim and uses a gpio-lib-c based wiringpi package - stored in the helper repository you can find on my account.
The wiringpi package was compiled and asembled from source on a Tinkerboard.
Use the tinkerboard/arm32v7/debian/build.sh shell to create a new docker image, and the armbian/run.sh to run it afterwards.
