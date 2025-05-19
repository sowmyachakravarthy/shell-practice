#!/bin/bash

NUMBER=$1

echo " enter the NUMBER : $1 " 

if [ $NUMBER -gt 50000 -lt 80000 ]

    echo "you can send only 5000 to your parents"

elif [ $NUMBER -gt 80000 ] 
then
    echo "you can now send 10000 to your parents"

else
    echo " don't send money to your parents, we can't afford now "

fi