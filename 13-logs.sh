#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "script started executing at: $(date)" tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "give $R ERROR and run the script with root access $N" tee -a $LOG_FILE
    exit 1 # give other than 0 up to 127
else
    echo "you are running with root acces" tee -a $LOG_FILE
fi
# validate takes input as exit status,what the command to install
VALIDATE(){
    if [ $1 -ne 0 ] # package take condition positive
    then
        echo -e "$2 installation is $G success $N" tee -a $LOG_FILE
    else
        echo -e "give $R ERROR $2 is not installed $N" tee -a $LOG_FILE
        exit 1
    fi
}
dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "give error ..mysql is going to install" tee -a $LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "MYSQL"
else
    echo -e "mysql is already $Y installed nothing to do $N" tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "give error ..python3 is going to install" tee -a $LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "python3 is already $Y installed nothing to do $N" tee -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "give error ..nginx is going to install" tee -a $LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "nginx"
else
    echo -e "nginx is already $Y installed nothing to do $N" tee -a $LOG_FILE
fi