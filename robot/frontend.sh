#!/bin/bash

echo I am frontend

# we need run the script as a root user
# we need to do validation first, we need check whether root use or not $ id  ( $ id -u)if uid is 0 then it is root

 ID=$(id -u)
 if [ $ID -ne 0 ] ; then
 echo -e "\e[31m You need to run the script either as a root user or with a sudo privilage \e[0m" 
 exit 1

 fi

# exit 1 means script will be terminated then and there itself
echo installing nginx
 yum install nginx -y   &>> /tmp/frontend.log
 if [ $? -eq 0] ; then 
       echo -e "\[36m success \[0m"
    else
        echo -e "\e[31m failure \[0m"
    fi
 systemctl enable nginx  &>> /tmp/frontend.log
echo starting nginx
 systemctl start nginx   &>> /tmp/frontend.log
 # $? tells the exit code of the last command
 # send the logs to temporary folder &>> this redirects the std.out and std.error 
