#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


if [ $USERID -ne 0 ]
then
    echo -e "give $R ERROR and run the script with root access $N" 
    exit 1 # give other than 0 up to 127
else
    echo "you are running with root acces" 
fi
# validate takes input as exit status,what the command to install
VALIDATE(){
    if [ $1 -eq 0 ] # package take condition positive
    then
        echo -e "$2 installation is $G success $N"
    else
        echo -e "give $R ERROR $2 is not installed $N" 
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
    echo -e "mysql is already $Y installed nothing to do $N" 
fi

dnf list installed python3 
if [ $? -ne 0 ]
then
    echo "give error ..python3 is going to install" 
    dnf install nginx -y 
    VALIDATE $? "python3"
else
    echo -e "python3 is already $Y installed nothing to do $N" 
fi

dnf list installed nginx 
if [ $? -ne 0 ]
then
    echo "give error ..nginx is going to install"
    dnf install nginx -y 
    VALIDATE $? "nginx"
else
    echo -e "nginx is already $Y installed nothing to do $N" 
fi