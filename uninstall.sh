#!/bin/bash

launchd_job="com.docker.monitor.restart"

if [[ -z "$(sudo launchctl list | awk '{print $3}' | grep $launchd_job)" ]] 
then                                                                          
    echo
    echo "Error: launch daemon not installed!"
    echo
    exit 1
fi                                                                            

sudo launchctl unload /Library/LaunchDaemons/$launchd_job.plist && \
sudo rm /usr/local/bin/docker_restart.sh && \
sudo rm /Library/LaunchDaemons/$launchd_job.plist && \
echo && \
echo "Launch daemon successfully uninstalled!" && \
echo
