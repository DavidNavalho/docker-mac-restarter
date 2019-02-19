#!/bin/bash
hostname=$1
port=$2

curl --silent --max-time 5 --output /dev/null $hostname:$port
result=$?
time=$(stat -f "%Sm" -t "[%Y-%m-%d %H:%M:%S]")

if [ $result -ne 0 ]
then
    echo "$time Docker container not responding on $hostname:$port. Restarting..."
    osascript -e 'quit app "Docker"' && open -a Docker
else
    echo "$time Docker container running and listening on $hostname:$port."
fi
