#!/bin/bash
#
# Echo DEBUG Info to the console
#
USER="$(whoami)"
USER_ID="$(id -u ${USER})"
echo "Starting deCONZ version: $DECONZ_VERSION"
echo "Service Account: $USER $USER_ID"
echo "Web UI port: $DECONZ_WEB_PORT"
echo "Websockets port: $DECONZ_WS_PORT"
echo "Device: $DECONZ_DEVICE"
echo "Notifications: (info)$DEBUG_INFO (APS)$DEBUG_APS (ZCL)$DEBUG_ZCL (ZDP)$DEBUG_ZDP (OTAU)$DEBUG_OTAU"
#
#
if [[ "$DECONZ_DEVICE" == /dev/ttyS* ]]; then
	echo "Symlinking Raspbee on ${DECONZ_DEVICE} to /dev/ttyAMA0"
	sudo ln -s "$DECONZ_DEVICE" /dev/ttyAMA0;
fi
#
# Set Permissions for home and peristent storage volumes
#
sudo chown -R "$USER":"$USER" /home/"$USER"/;
sudo chown -R "$USER":root /home/"$USER"/.local;
sudo chown -R "$USER":root /home/"$USER"/otau;
cd /home/"$USER";
#
# Start deCONZ
#
if [ "$DECONZ_DEVICE" != "/dev/null" ]; then
	/usr/bin/deCONZ \
		-platform minimal \
		--auto-connect=1 \
		--http-port="$DECONZ_WEB_PORT" \
		--ws-port="$DECONZ_WS_PORT" \
		--dev="$DECONZ_DEVICE" \
		--dbg-info="$DEBUG_INFO" \
		--dbg-aps="$DEBUG_APS" \
		--dbg-zcl="$DEBUG_ZCL" \
		--dbg-zdp="$DEBUG_ZDP" \
		--dbg-otau="$DEBUG_OTAU" \
	;
else
    echo "No Device defined, aborting initialization"
fi
