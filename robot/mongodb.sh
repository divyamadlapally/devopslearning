#!/bin/bash
set -e

COMPONENT=mongodb
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

echo -n "Downloading $COMPONENT : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "installing $COMPONENT : "
yum install -y mongodb-org  &>> $LOGFILE
stat $?

echo -n "statring $COMPONENT : "
systemctl enable mongod    &>> $LOGFILE
systemctl start mongod     &>> $LOGFILE
stat $?

echo -n "Downloading the $COMPONENT schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT schema file : "
cd /tmp
unzip mongodb.zip    &>> $LOGFILE
stat $?

echo -n "Injecting the schema : "
cd mongodb-main
mongo < catalogue.js     &>> $LOGFILE
mongo < users.js           &>> $LOGFILE
stat $?