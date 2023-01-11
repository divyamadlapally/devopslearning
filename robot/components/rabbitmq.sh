#!/bin/bash
COMPONENT=rabbitmq

source components/common.sh

echo -n " Installing and configuring $COMPONENT repo : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash   &>> "${LOGFILE}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash     &>> "${LOGFILE}"
stat $?

echo -n " Installing $COMPONENT : "
yum install rabbitmq-server -y   &>> "${LOGFILE}"
stat $?

echo -n "Starting $COMPONENT server : "
systemctl enable rabbitmq-server   &>> "${LOGFILE}"
systemctl start rabbitmq-server     &>> "${LOGFILE}"
systemctl status rabbitmq-server -l     &>> "${LOGFILE}"
stat $?

sudo rabbitmqctl list_users | grep "${APPUSER}"     &>>"${LOGFILE}"
if [ $? -ne 0 ]; then
    echo -n "Creating application user on $COMPONENT : "
    rabbitmqctl add_user roboshop roboshop123    &>> "${LOGFILE}"   
    stat $?
fi

echo -n "Adding Permissions to $APPUSER : "
rabbitmqctl set_user_tags roboshop administrator       &>> "${LOGFILE}"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"    &>> "${LOGFILE}"
stat $?

echo -e "\e[32m_____$COMPONENT Configuration is completed______\e[0m"






