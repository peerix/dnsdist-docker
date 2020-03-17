#!/bin/sh

docker build -t peerix/dnsdist . -f Dockerfile --network=host
