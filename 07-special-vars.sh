#!/bin/bash

echo "all variables passed in script: $@"
echo "no variables passed in script: $#"
echo "name of the script: $0"
echo "present working directory: $PWD"
echo "home directory of the user who is running script: $HOME"
echo "User who is running the script: $USER"
echo "PID of the script: $$"
sleep 10 &
echo "PID of the last working command in background: $!"