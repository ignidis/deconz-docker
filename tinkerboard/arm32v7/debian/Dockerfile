FROM builder:deconz-arm32v7-debian

#
# Build Time Arguments
#
ARG	NAME
ARG	DECONZ_VERSION
ARG	DECONZ_SVC_NAME
ARG	DECONZ_SVC_UID

#
# Do some bookeeping for the repository and openshift
#
#
# It is deprecated but guess what...There are a lot of tools that still use it
#
MAINTAINER ignidis(at)cybearth(dot)net (https://github.com/ignidis/deconz-docker)

#
# And this is for those new tools
#
LABEL summary="Smarthome Platform based on dresden elektronics ${NAME}-${DECONZ_VERSION} Zigbee platform plugin (https://github.com/dresden-elektronik/deconz-rest-plugin/)" \
      description="This image is designed to run on the ASUS Tinkerboard using dresden elektronics Zigbee Gateway adapters Raspbee or Conbee" \
      io.openshift.expose-services="80:http" \
      io.openshift.expose-services="443:https" \
      name="${NAME}" \
      version="${DECONZ_VERSION}-amd64-centos" \
      maintainer="ignidis(at)cybearth(dot)net" \
      help="For more information visit https://github.com/ignidis/deconz-docker"

#
# Setup runtime variables
#
ENV	DECONZ_WEB_PORT=80 \
	DECONZ_WS_PORT=443 \
	DEBUG_INFO=1 \
	DEBUG_APS=0 \
	DEBUG_ZCL=0 \
	DEBUG_ZDP=0 \
	DEBUG_OTAU=0 \
	DECONZ_DEVICE="/dev/null"

#
# Create the Configuration and the OTAU directory
#
VOLUME	/home/${DECONZ_SVC_NAME}/.local/share/dresden-elektronik/deCONZ /home/${DECONZ_SVC_NAME}/otau

#
# Publish the web app and sockets ports
#
EXPOSE ${DECONZ_WEB_PORT} ${DECONZ_WS_PORT}

USER	${DECONZ_SVC_UID}
WORKDIR "/opt/deconz/"
ENTRYPOINT [ "/opt/deconz/deCONZ-run.sh" ]

#
# For testing and debugging comment out the above ENTRYPOINT and uncomment the following
#
#WORKDIR "/home/${DECONZ_SVC_NAME}/"
#ENTRYPOINT [ "/bin/bash" ]

