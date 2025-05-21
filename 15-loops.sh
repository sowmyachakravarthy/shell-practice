#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("MySQL" "python" "nginx")

mkdir -p $LOGS_FOLDER
echo "script started executing at: $(date)"

echo "Test line" >>$LOG_FILE


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
        echo -e "Installing $2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "Installing $2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

for package in ${PACKAGES[@]}
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed... going to install it" | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
    echo -e "Nothing to do $package... $Y already installed $N" | tee -a $LOG_FILE
fi


# dnf list installed python3 &>>$LOG_FILE
# if [ $? -ne 0 ]
# then
#     echo "python3 is not installed... going to install it" | tee -a $LOG_FILE
#     dnf install python3 -y &>>$LOG_FILE
#     VALIDATE $? "python3"
# else
#     echo -e "Nothing to do python... $Y already installed $N" | tee -a $LOG_FILE
# fi

# dnf list installed nginx &>>$LOG_FILE
# if [ $? -ne 0 ]
# then
#     echo "nginx is not installed... going to install it" | tee -a $LOG_FILE
#     dnf install nginx -y &>>$LOG_FILE
#     VALIDATE $? "nginx"
# else
#     echo -e "Nothing to do nginx... $Y already installed $N" | tee -a $LOG_FILE
# fi