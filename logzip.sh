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



cp $SOURCE_DIR/messages $DEST_DIR 
echo "Copying messages"


>$SOURCE_DIR/messages 
echo "nullifying messages in /var/log"


cd $DEST_DIR 
echo "cd to $DEST_DIR"


gzip messages 
echo "zipping messages"

mv messages.gz messages.$DATE.gz 
echo "Renaming zip file"


mv messages.$DATE.gz $SOURCE_DIR 
echo "Moving zip file to $SOURCE_DIR"


