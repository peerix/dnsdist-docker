#!/bin/sh

docker run -it -p 5053:53 -p 5053:53/udp --name pdns-dnsdist \
	-e PDNS_resolver_server=172.10.10.1:5300 \
	-e PDNS_auth_server=172.10.10.2:5301 \
	-e PDNS_packet_cache=100000 \
	-e PDNS_webserver=127.0.0.1:8083 \
	-e PDNS_webserver_password=secretski \
	-e PDNS_webserver_api_key=test123 \
	argirov/pdns-dnsdist
