#$!/bin/bash
#
docker run -d \
	-t \
	--init \
	--name="deconz" \
	--restart="unless-stopped" \
	--user="9001" \
	--volume="/etc/localtime:/etc/localtime:ro" \
	--volume="/var/lib/services/deconz/config:/home/deconz/.local/share/dresden-elektronik/deCONZ" \
	--volume="/var/lib/services/deconz/otau:/home/deconz/otau" \
	--device="/dev/gpiomem" \
	--device="/dev/ttyS1" \
	-e DECONZ_DEVICE="/dev/ttyS1" \
	--network="bridge" \
	-p 8080:8080 \
	-p 8443:8443 \
	-e DECONZ_WEB_PORT="8080" \
	-e DECONZ_WS_PORT="8443" \
	-e DEBUG_INFO="0" \
	-e DEBUG_APS="0" \
	-e DEBUG_ZCL="1" \
	-e DEBUG_ZDP="0" \
	-e DEBUG_OTAU="0" \
	-e DECONZ_VERSION="$1" \
	deconz:"$1"-arm32v7-debian;

