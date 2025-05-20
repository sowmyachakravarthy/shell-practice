#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1 #give other than 0 upto 127
else
    echo "You are running with root access"
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "Installing $2 is ... $G SUCCESS $N"
    else
        echo -e "Installing $2 is ... $R FAILURE $N"
        exit 1
    fi
}

dnf list installed TaniumClient
if [ $? -ne 0 ]
then
    echo "MySQL is not installed... going to install it"
    rpm -ivh TaniumClient-7.4.10.1060-1.rhe9.x86_64.rpm
    VALIDATE $? "TaniumClient"
else
    echo -e "Nothing to do TaniumClient... $Y already installed $N"
fi

dnf list installed CrowdStrike
if [ $? -ne 0 ]
then
    echo "python3 is not installed... going to install it"
    rpm -ivh falcon-sensor-7.13.0-16604.el9.x86_64.rpm
    VALIDATE $? "CrowdStrike"
else
    echo -e "Nothing to do CrowdStrike... $Y already installed $N"
fi
