#!/bin/bash

COMPONENT=mongodb

source components/common.sh


# source load a file which has all the common patterns.
# we need run the script as a root user
# we need to do validation first, we need check whether root use or not $ id  ( $ id -u)if uid is 0 then it is root
# exit 1 means script will be terminated then and there itself

echo -n "Downloading $COMPONENT : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "installing $COMPONENT : "
yum install -y mongodb-org  &>> "${LOGFILE}"
stat $?

echo -n "statring $COMPONENT : "
systemctl enable mongod    &>> "${LOGFILE}"
systemctl start mongod     &>> "${LOGFILE}"
stat $?

echo -n "Downloading the $COMPONENT schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT schema file : "
cd /tmp
unzip -o mongodb.zip    &>> "${LOGFILE}"
stat $?
# -o gives overriding
echo -n "Injecting the schema : "
cd mongodb-main
mongo < catalogue.js     &>> "${LOGFILE}"
mongo < users.js           &>> "${LOGFILE}"
stat $?