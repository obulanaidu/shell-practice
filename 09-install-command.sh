#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "error:: please run the script with root access"
    exit 1 # give other than 0 up to 127
else
    echo " you are running with root acess"
fi
# check already installed or not.if installed $? is 0
# if not installed $? -ne 0 then expression is true so now install

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "mysql no installed..going to install"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
       echo "installing mysql is success"
    else
       echo "installing mysql is failure"
       exit 1
    fi
else
    echo "mysql is already installed..nothing to do"
fi

# dnf install mysql -y

# if [ $USERID -eq 0 ]
# then
#     echo "installing mysql is success"
# else
#     echo "installing mysql is failure"
#     exit 1
# fi