#!/bin/sh
myip='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   myip=`hostname -I | awk '{print $1}'`
elif [[ "$unamestr" == 'Darwin' ]]; then
   myip=`ipconfig getifaddr en0`
else
   echo "Unsupported platform, please extend this script for your it."
   exit 1
fi

export EXTERNAL_IP=$myip
export INFLUX_DIR=$(dirname `pwd`)

echo "Starting Docker containers running on IP adress: ${EXTERNAL_IP}"
exec docker-compose $@