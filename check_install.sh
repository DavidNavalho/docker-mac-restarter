#!/bin/bash

launchd_job="com.docker.monitor.restart"

if [[ ! -z "$(sudo launchctl list | awk '{print $3}' | grep $launchd_job)" ]] 
then                                                                          
    echo
    echo "Info: launch daemon IS installed!"
    echo
else
    echo
    echo "Info: launch daemon IS NOT installed!"
    echo
fi 
