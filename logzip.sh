#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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



cp $SOURCE_DIR/messages $DEST_DIR &>>$LOG_FILE
VALIDATE $? "Copying messages to $DEST_DIR"

>$SOURCE_DIR/messages &>>$LOG_FILE
VALIDATE $? "Nullifying messages"

cd $DEST_DIR &>>$LOG_FILE
VALIDATE $? "Going to $DEST_DIR"

gzip messages &>>$LOG_FILE
VALIDATE $? "Zipping Messages"

mv messages.gz messages.$DATE.gz &>>$LOG_FILE
VALIDATE $? "Renaming the file"

mv messages.$DATE.gz $SOURCE_DIR &>>$LOG_FILE
VALIDATE $? "Placing the zip file in $SOURCE_DIR"

