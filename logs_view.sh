#!/bin/bash

lines=$1
lines=${lines:-20}

echo "Show last $lines lines per log (press CTRL+C to close):"
tail -f -n $lines ~/Library/Logs/com.docker.monitor.restart.std*.log
