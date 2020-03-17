#!/bin/sh

docker run -d -it \
	--name dnsdist \
	-p 53:53/udp \
	-p 53:53/tcp \
	-p 8083:8083/tcp \
	-v /opt/etc:/opt/etc \
	-e PDNS_local_ipv4=0.0.0.0:53 \
	-e PDNS_resolver_server=127.0.0.1:5300 \
	-e PDNS_auth_server=127.0.0.1:5301 \
	-e PDNS_packet_cache=100000 \
	-e PDNS_webserver=0.0.0.0:8083 \
	-e PDNS_webserver_password=secret \
	-e PDNS_webserver_api_key=apikey \
	-e PDNS_allow_acl=0.0.0.0/0 \
	peerix/dnsdist
