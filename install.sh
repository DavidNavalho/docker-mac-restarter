#!/bin/bash

launchd_job="com.docker.monitor.restart"
default_hostname="localhost"
default_port=80
default_start_interval=300
username=$(whoami)

if [[ ! -z "$(sudo launchctl list | awk '{print $3}' | grep $launchd_job)" ]]
then
    echo
    echo "Error: launch daemon already installed!"
    echo
    exit 1
fi

echo
read -p "Hostname [$default_hostname]: " hostname
hostname=${hostname:-$default_hostname}

read -p "Port [$default_port]: " port
port=${port:-$default_port}

read -p "Interval (sec) [$default_start_interval]: " start_interval
start_interval=${start_interval:-$default_start_interval}

echo
echo "=================================================="
echo
echo "This launch daemon is going to test the following"
echo "hostname and port. Please review the input fields"
echo "and press the Y key if the input data is correct."
echo
echo " Hostname : $hostname"
echo "     Port : $port"
echo "    Every : $start_interval seconds"
echo "   Run as : $username"
echo
echo "=================================================="
echo
read -n1 -p "Are you sure you want to continue? [yN] " question
echo

if [[ ! $question =~ ^(y|Y)$ ]]
then
    echo
    echo "Closing..."
    echo
    exit 0
fi

echo
echo "Installing... "

cp root-fs/Library/LaunchDaemons/$launchd_job.plist.template root-fs/Library/LaunchDaemons/$launchd_job.plist && \
sed -i.template \
    -e "s/\$hostname/${hostname=localhost}/g" \
    -e "s/\$port/${port=80}/" \
    -e "s/\$start_interval/${start_interval=300}/" \
    -e "s/\$username/$username/" \
    root-fs/Library/LaunchDaemons/$launchd_job.plist && \
\
sudo cp root-fs/Library/LaunchDaemons/$launchd_job.plist /Library/LaunchDaemons/ && \
sudo cp root-fs/usr/local/bin/docker_restart.sh /usr/local/bin/ && \
sudo launchctl load -w /Library/LaunchDaemons/com.docker.monitor.restart.plist && \
\
echo && \
echo "Done!" && \
echo
