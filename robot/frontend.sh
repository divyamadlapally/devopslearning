#!/bin/bash
COMPONENT=frontend


# we need run the script as a root user
# we need to do validation first, we need check whether root use or not $ id  ( $ id -u)if uid is 0 then it is root

 ID=$(id -u)
 if [ $ID -ne 0 ] ; then
 echo -e "\e[31m You need to run the script either as a root user or with a sudo privilage \e[0m" 
 exit 1
 # exit 1 means script will be terminated then and there itself


stat() 
{
    if [ $1 -eq 0 ]; then 
       echo -e "\e[32m success \e[0m"
    else
        echo -e "\e[31m failure \e[0m"
    fi
}

echo -n "installing nginx :"
yum install nginx -y   &>> /tmp/frontend.log
stat $?

echo -n "starting nginx :"
systemctl enable nginx  &>> /tmp/frontend.log
systemctl start nginx   &>> /tmp/frontend.log
stat $?

 # $? tells the exit code of the last command
 # send the logs to temporary folder &>> this redirects the std.out and std.error 
echo -n "downloading the $COMPONENT :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
