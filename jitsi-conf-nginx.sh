#!/bin/bash

docker cp /opt/jitsi/meet.conf docker-jitsi-meet-web-1:/config/nginx/meet.conf
#docker cp /opt/jitsi/config.js docker-jitsi-meet-web-1:/usr/share/jitsi-meet/config.js
docker exec -it docker-jitsi-meet-web-1 nginx -s reload
