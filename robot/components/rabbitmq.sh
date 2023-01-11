#!/bin/bash
COMPONENT=rabbitmq

source common.sh

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

echo -n "Creating $COMPONENT user : "
rabbitmqctl add_user roboshop roboshop123
stat $?

echo -n "Configuring Tags and Permissions to $APPUSER : "
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?

echo -e "\e[32m_____$COMPONENT Configuration is completed______\e[0m"






