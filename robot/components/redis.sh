#!/bin/bash

COMPONENT=redis

source components/common.sh

echo -n "Configuring  $COMPONENT repo"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?

echo -n "Installing $COMPONENT : "
yum install redis-6.2.7 -y    &>> "${LOGFILE}"
stat $?

echo -n "whitelisting the $COMPONENT"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
stat $?

echo -n "statring $COMPONENT : "
systemctl enable $COMPONENT   &>> "${LOGFILE}"
systemctl start $COMPONENT     &>> "${LOGFILE}"
stat $?
