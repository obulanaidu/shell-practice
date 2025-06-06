#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python3" "nginx" "httpd")

mkdir -p $LOGS_FOLDER
echo "script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "give $R ERROR and run the script with root access $N" tee -a $LOG_FILE
    exit 1 # give other than 0 up to 127
else
    echo "you are running with root acces" tee -a $LOG_FILE
fi
# validate takes input as exit status,what the command to install
VALIDATE(){
    if [ $1 -eq 0 ] 
    then
        echo -e "$2 installation is $G success $N" tee -a $LOG_FILE
    else
        echo -e "give $R ERROR $2 is not installed $N" tee -a $LOG_FILE
        exit 1
    fi
}
for package in ${PACKAGES[@]}
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "give error ..$package is going to install" tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? $package
    else
        echo -e $package is already $Y installed nothing to do $N" tee -a $LOG_FILE
    fi
done

