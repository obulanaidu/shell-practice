#!/bin/bash

uSERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "error:: please run the user with root access"
else
    echo " you are running with root acess"
fi