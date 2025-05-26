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


>$SOURCE_DIR/messages 


cd $DEST_DIR 


gzip messages 


mv messages.gz messages.$DATE.gz 


mv messages.$DATE.gz $SOURCE_DIR 


