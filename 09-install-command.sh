#!/bin/bash

uSERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "error:: please run the script with root access"
else
    echo " you are running with root acess"
fi

dnf install mysql -y

if [ $USERID -eq 0 ]
then
    echo "mysql is success"
else
    echo "mysql is failure"
fi