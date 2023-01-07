#!/bin/bash

echo I am frontend

# we need run the script as a root user
# we need to do validation first, we need check whether root use or not $ id  ( $ id -u)if uid is 0 then it is root

 UID=$(id -u)
 if [$UID -ne 0] ; then
 echo -e "\e[31m You need to run the script either as a root user or with a sudo privilage \e[0m" 
 exit 1

 fi

# exit 1 means script will be terminated then and there itself

 yum install nginx -y
 systemctl enable nginx
 systemctl start nginx

