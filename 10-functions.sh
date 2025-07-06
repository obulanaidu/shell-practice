#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "give error and run the script with root access"
    exit 1 # give other than 0 up to 127
else
    echo "you are running with root acces"
fi
# validate takes input as exit status,what the command to install
VALIDATE(){
    if [ $1 -eq 0 ] # package take condition positive
    then
        echo "$2 installation is success" 
    else
        echo "give error $2 is not installed"
        exit 1
    fi
}
dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "give error ..mysql is going to install"
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else
    echo "mysql is already installed nothing to do"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo "give error ..python3 is going to install"
    dnf install nginx -y
    VALIDATE $? "python3"
else
    echo "python3 is already installed nothing to do"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "give error ..nginx is going to install"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo "nginx is already installed nothing to do"
fi