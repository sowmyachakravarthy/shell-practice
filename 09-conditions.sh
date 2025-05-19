#!/bin/bash


read -p "Enter your Salary: " NUMBER 

if [ $NUMBER -gt 50000 ] && [ $NUMBER -lt 79999 ]
then

    echo "you can send only 5000 to your parents"

elif [ $NUMBER -gt 80000 ] 
then
    echo "you can now send 10000 to your parents"

else
    echo " don't send money to your parents, we can't afford now "

fi