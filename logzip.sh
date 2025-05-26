#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/test"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER.log"

SOURCE_DIR="/var/log/"
DEST_DIR=$1
DATE=$(date +%d%m%Y)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1 #give other than 0 upto 127
else
    echo "You are running with root access"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}


cp $SOURCE_DIR/messages $DEST_DIR &>>$LOG_FILE
VALIDATE $? "Copying messages"

>$SOURCE_DIR/messages &>>$LOG_FILE
VALIDATE $? "nullifying messages in /var/log"

cd $DEST_DIR &>>$LOG_FILE
VALIDATE $? "cd to $DEST_DIR"

gzip messages &>>$LOG_FILE
VALIDATE $? "zipping messages"

mv messages.gz messages.$DATE.gz &>>$LOG_FILE
VALIDATE $? "Renaming zip file"

mv messages.$DATE.gz $SOURCE_DIR &>>$LOG_FILE
VALIDATE $? "Moving zip file to $SOURCE_DIR"


