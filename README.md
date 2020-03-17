# PowerDNS's dnsdist Docker image

General purpose dndist container used to direct traffic to resolvers or
authoritative name server

## Build

```shell
./build.sh
```

## Run

```shell
./run.sh
```

or manually

```shell
docker run -d -it \
        --name dnsdist \
        -p 53:53/udp \
        -p 53:53/tcp \
        -p 8083:8083/tcp \
        -e PDNS_local_ipv4=0.0.0.0:53 \
        -e PDNS_resolver_server=127.0.0.1:5300 \
        -e PDNS_auth_server=127.0.0.1:5301 \
        -e PDNS_packet_cache=100000 \
        -e PDNS_webserver=0.0.0.0:8083 \
        -e PDNS_webserver_password=secret \
        -e PDNS_webserver_api_key=apikey \
        -e PDNS_allow_acl=0.0.0.0/0 \
        peerix/dnsdist
```

The existing dnsdist.conf.tmpl can be extended to add more configuration 
variables if required.

Current list of available variables is:

* PDNS_local_ipv4
* PDNS_local_ipv6
* PDNS_resolver_server
* PDNS_auth_server
* PDNS_packet_cache
* PDNS_webserver
* PDNS_webserver_password
* PDNS_webserver_api_key
* PDNS_allow_acl
* PDNS_control_socket
* PDNS_control_socket_acl

## Connect to dnsdist console

```shell
$ docker exec -it dnsdist dnsdist -c
> showBinds()
#   Address                        Protocol              Queries
0   0.0.0.0:53                     UDP                   0
1   0.0.0.0:53                     TCP                   0
2   [::]:53                        UDP                   0
3   [::]:53                        TCP                   0
> showServers()
#   Name                 Address                       State     Qps    Qlim Ord Wt    Queries   Drops Drate   Lat Outstanding Pools
0   127.0.0.1:5300       127.0.0.1:5300                 down     0.0       1   1  1          0       0   0.0   0.0           0 resolver_internal
1   127.0.0.1:5301       127.0.0.1:5301                 down     0.0       0   1  1          0       0   0.0   0.0           0 auth_external
All                                                              0.0                         0       0                         
> 
```

## Check logs

```shell
$ docker logs dnsdist
Read configuration from '/etc/dnsdist/dnsdist.conf'
Added downstream server 127.0.0.1:5300
Creating pool resolver_internal
Adding server to pool resolver_internal
Added downstream server 127.0.0.1:5301
Creating pool auth_external
Adding server to pool auth_external
Creating pool resolver_external
Listening on 0.0.0.0:53
Listening on [::]:53
dnsdist 1.4.0.650.master.gac33f1fab comes with ABSOLUTELY NO WARRANTY. This is
free software, and you are welcome to redistribute it according to the terms of
the GPL version 2
ACL allowing queries from: 0.0.0.0/0
Console ACL allowing connections from: 127.0.0.1/32
Accepting control connections on 127.0.0.1:5199
Webserver launched on 0.0.0.0:8083
Marking downstream 127.0.0.1:5300 as 'down'
Marking downstream 127.0.0.1:5301 as 'down'
Adding TCP Client thread
Adding TCP Client thread

```
