#!/bin/sh

export PDNS_resolver_server PDNS_auth_server PDNS_packet_cache
export PDNS_webserver PDNS_webserver_password PDNS_webserver_api_key

if [ -f /etc/debian_version ]; then
	config_file=/etc/dnsdist/dnsdist.conf
	dnsdist_user=_dnsdist
fi

/usr/local/bin/envsubst < /etc/dnsdist/dnsdist.conf.tmpl > $config_file

chown ${dnsdist_user}: $config_file

exec "$@" 
