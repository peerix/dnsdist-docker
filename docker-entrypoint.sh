#!/bin/sh

export PDNS_resolver_server PDNS_auth_server PDNS_packet_cache
export PDNS_webserver PDNS_webserver_password PDNS_webserver_api_key

if [ -f /etc/debian_version ]; then
	config_file=/etc/dnsdist/dnsdist.conf
	dnsdist_user=_dnsdist
fi

/usr/local/bin/envsubst < /etc/dnsdist/dnsdist.conf.tmpl > $config_file

# if config files are on persistent storage, make sure that we do not regenerate the key all the time
if ! grep -q "setKey" $config_file; then
	echo "makeKey()" | stdbuf -o0 dnsdist -l 127.0.0.1:9999 | grep -Po "\K(setKey\(\".*\"\))" >> $config_file
fi

chown ${dnsdist_user}: $config_file

exec "$@" 
