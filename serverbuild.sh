#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/build-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("TaniumClient" "CrowdStrike" "Opsware" "Rapid7")
#INSTALL_METHODS=([TaniumClient]="TaniumClient-7.4.10.1060-1.rhe9.x86_64" [CrowdStrike]="falcon-sensor-7.13.0-16604.el9.x86_64" )

mkdir -p $LOGS_FOLDER
echo "script started executing at: $(date)"

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
        echo -e "Installing $2 is ... $G SUCCSS $N"
    else
        echo -e "Installing $2 is ... $R FAILURE $N"
        exit 1
    fi
}



for package in ${PACKAGES[@]}
    do
    echo "checking package..." | tee -a $LOG_FILE

    if $package = "rpm" then
    echo "Using rpm to install $package" | tee -a "$LOG_FILE"
    echo "pretend rpm -ivh $package.rpm" >> "$LOG_FILE"

    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed... going to install it" | tee -a $LOG_FILE
        echo "pretend install" &>>$LOG_FILE
        VALIDATE $? "$package"
    else
    echo -e "Nothing to do $package... $Y already installed $N" | tee -a $LOG_FILE
    fi
done    

# dnf list installed TaniumClient
# if [ $? -ne 0 ]
# then
#     echo "TaniumClient is not installed... going to install it"
#     echo "pretend install"
#     VALIDATE $? "TaniumClient installation"

#     /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList "Ts1.avivagroup.com 10.77.252.4, Ts2.avivagroup.com 10.78.252.4, Tsmodule.avivagroup.com 10.77.253.21"
#     VALIDATE $? "ServerNameList config"

#     /opt/Tanium/TaniumClient/TaniumClient config set ServerPort 62211
#     VALIDATE $? "ServerPort config"

#     /opt/Tanium/TaniumClient/TaniumClient config set Resolver nslookup
#     VALIDATE $? "Resolver config"

# else
#     echo -e "Nothing to do TaniumClient... $Y already installed $N"
# fi

# # dnf list installed CrowdStrike
# # if [ $? -ne 0 ]
# # then
# #     echo "python3 is not installed... going to install it"
# #     rpm -ivh falcon-sensor-7.13.0-16604.el9.x86_64.rpm
# #     VALIDATE $? "CrowdStrike"
# # else
# #     echo -e "Nothing to do CrowdStrike... $Y already installed $N"
# # fi
