FROM debian:latest
MAINTAINER "atanas argirov" <atanas@argirov.org>

# install gnupg2 & curl
RUN apt update && apt install -y gnupg2 curl netcat dnsutils tcpdump

# add powerdns repo
COPY apt.pdns.repo /etc/apt/sources.list.d/pdns.list
COPY apt.pdns.pref /etc/apt/preferences.d/pdns 
RUN curl https://repo.powerdns.com/CBC8B383-pub.asc | apt-key add -
# get envsubst
#RUN curl -L https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-`uname -s`-`uname -m` -o /usr/local/bin/envsubst && chmod +x /usr/local/bin/envsubst
# update repo
RUN apt update && apt install -y dnsdist pdns-recursor

EXPOSE 53 53/udp

#COPY dnsdist.conf.tmpl /etc/dnsdist/dnsdist.conf.tmpl
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
