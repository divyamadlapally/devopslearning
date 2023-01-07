#!/bin/bash

set -e

COMPONENT=frontend
LOGFILE=/tmp/$COMPONENT.log


# we need run the script as a root user
# we need to do validation first, we need check whether root use or not $ id  ( $ id -u)if uid is 0 then it is root

 ID=$(id -u)
 if [ $ID -ne 0 ] ; then
    echo -e "\e[31m You need to run the script either as a root user or with a sudo privilage \e[0m" 
    exit 1
 fi
 # exit 1 means script will be terminated then and there itself


stat() 
{
    if [ $1 -eq 0 ]; then 
       echo -e "\e[32m success \e[0m"
    else
        echo -e "\e[31m failure \e[0m"
    fi
}

echo -e "\e[32m ______ $COMPONENT configuration is starting_______\e[0m"

echo -n "installing nginx :"
yum install nginx -y   &>> $LOGFILE
stat $?

echo -n "starting nginx :"
systemctl enable nginx  &>> $LOGFILE
systemctl start nginx   &>> $LOGFILE

 # $? tells the exit code of the last command
 # send the logs to temporary folder &>> this redirects the std.out and std.error 

echo -n "downloading the $COMPONENT :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "clearing the  default content :"
cd /usr/share/nginx/html
rm -rf *   &>> $LOGFILE
stat $?

echo -n "Extracting $COMPONENT :" 
unzip /tmp/$COMPONENT.zip   &>> $LOGFILE
stat $?

echo -n "Copying $COMPONENT :"
mv frontend-main/* .         &>> $LOGFILE
mv static/* .                &>> $LOGFILE
rm -rf frontend-main README.md       &>> $LOGFILE
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting nginx :"
systemctl enable nginx  &>> $LOGFILE
systemctl start nginx   &>> $LOGFILE
stat $?

echo -e "\e[32m ______ $COMPONENT configuration completed_______\e[0m"
