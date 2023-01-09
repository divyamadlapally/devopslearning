#!/bin/bash

COMPONENT=catalogue

source components/common.sh

echo -n "Configuring the nodejs repo: "
curl -sL https://rpm.nodesource.com/setup_16.x | bash       &>> "${LOGFILE}"
yum install nodejs -y   &>>  "${LOGFILE}"
stat $?

id $APPUSER       &>>  "${LOGFILE}"
if [ $? -ne 0 ] ; then
    echo -n "Creating Application User $APPUSER : "
    useradd $APPUSER      &>>  "${LOGFILE}"
    stat $?
fi
echo -n "Downloading the $COMPONENT : "
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT : "
cd /home/$APPUSER
unzip -o /tmp/catalogue.zip    &>>  "${LOGFILE}"