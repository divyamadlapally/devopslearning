#!/bin/bash
set -e

COMPONENT=catalogue

source common.sh

echo -n "Configuring the nodejs repo: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install nodejs -y   &>> $LOGFILE
stat $?

echo -n "Creating Application User $APPUSER "
useradd $APPUSER
stat $?

