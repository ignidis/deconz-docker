FROM arm32v7/debian:stretch-slim

#
# Build Time Arguments
#
ARG	DECONZ_VERSION
ARG	DECONZ_SVC_NAME
ARG	DECONZ_SVC_UID

#
# Runtime environment variables
#
ENV	DECONZ_WEB_PORT=8080 \
	DECONZ_WS_PORT=8443 \
	DEBUG_INFO=1 \
	DEBUG_APS=0 \
	DEBUG_ZCL=0 \
	DEBUG_ZDP=0 \
	DEBUG_OTAU=0 \
	DECONZ_DEVICE="/dev/null"

#
# Update the operating system and install required packges
#
RUN	WIRINGPI_VERSION="2.31-TB"; \
	export DEBIAN_FRONTEND="noninteractive"; \
	export TERM="xterm"; \
	apt-get update; \
	apt-get install -y --no-install-recommends --autoremove apt-utils wget ca-certificates; \
	apt-get install -y --no-install-recommends --autoremove \
	sudo \
	libcap2-bin \
	libqt5core5a \
	libqt5gui5 \
	libqt5network5 \
	libqt5serialport5 \
	libqt5sql5 \
	libqt5websockets5 \
	libqt5widgets5 \
	sqlite3 \
	; \
#
# Define Service Account variables
#
	SERVICE_USER=${DECONZ_SVC_NAME}; \
	SERVICE_USER_UID=${DECONZ_SVC_UID}; \
	SERVICE_GROUP=${DECONZ_SVC_NAME}; \
	SERVICE_GROUP_UID=${DECONZ_SVC_UID}; \
	ADD_GROUPS="sudo,dialout"; \
#
# Create service group and service account
#
	groupadd -g $SERVICE_GROUP_UID $SERVICE_GROUP; \
	useradd -u $SERVICE_USER_UID -g $SERVICE_GROUP --groups $ADD_GROUPS --shell /bin/bash --create-home $SERVICE_USER; \
#
# Allow service account to sudo without pasword
#
	echo 'deconz ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/090_deconz-nopasswd; \
#
# CWD
#
	cd /home/$SERVICE_USER/; \
#
# Install WIRINPI as long as this is a required dependency
#
#	wget https://archive.raspberrypi.org/debian/pool/main/w/wiringpi/wiringpi_${WIRINGPI_VERSION}_armhf.deb; \
#
# For the Tinker Board we use the gpio_lib_c packaged as wiringpi package in order to satisfy dependencies 
#
#
	wget https://github.com/ignidis/deconz-docker-helper/raw/master/wiringpi_${WIRINGPI_VERSION}_armhf.deb; \
	dpkg -i ./wiringpi_${WIRINGPI_VERSION}_armhf.deb; \
	rm -f ./wiringpi_${WIRINGPI_VERSION}_armhf.deb;\
#
# Install deCONZ and fix the ownership
#
	wget https://www.dresden-elektronik.de/rpi/deconz/beta/deconz-${DECONZ_VERSION}-qt5.deb; \
	apt-get install -y ./deconz-${DECONZ_VERSION}-qt5.deb; \
	rm -f ./deconz-${DECONZ_VERSION}-qt5.deb; \
	chown root:root /usr/bin/deCONZ*; \
	setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/deCONZ; \
	mkdir /opt/deconz; \
	chown -R $SERVICE_USER:$SERVICE_GROUP /opt/deconz; \
#
#
# Clean the apt cache and remove packages needed only for the installation
#
	apt-get -y --purge remove ca-certificates wget apt-utils; \
	apt -y autoremove; \
	apt-get clean -y; \
	rm -rf /var/lib/apt/lists/*;
#
# Create the Configuration and the OTAU directory
#
VOLUME	/home/${DECONZ_SVC_NAME}/.local/share/dresden-elektronik/deCONZ /home/${DECONZ_SVC_NAME}/otau

#
# Publish the web app and sockets ports
#
EXPOSE ${DECONZ_WEB_PORT} ${DECONZ_WS_PORT}

#
# Copy the start command
#
USER	${DECONZ_SVC_UID}
COPY	deCONZ-run.sh /opt/deconz/deCONZ-run.sh
RUN	sudo chmod +x /opt/deconz/deCONZ-run.sh

WORKDIR "/opt/deconz/"
ENTRYPOINT [ "/opt/deconz/deCONZ-run.sh" ]
#
# For testing and debugging comment out the above ENTRYPOINT and uncomment the following
#
#WORKDIR "/home/${DECONZ_SVC_NAME}/"
#ENTRYPOINT [ "/bin/bash" ]

