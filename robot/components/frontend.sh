#!/bin/bash


COMPONENT=frontend

source components/common.sh


# we need run the script as a root user
# we need to do validation first, we need check whether root use or not $ id  ( $ id -u)if uid is 0 then it is root
# exit 1 means script will be terminated then and there itself


echo -e "\e[32m ______ $COMPONENT configuration is starting_______\e[0m"

echo -n "installing nginx :"
yum install nginx -y   &>> "${LOGFILE}"
stat $?

echo -n "starting nginx :"
systemctl enable nginx  &>> "${LOGFILE}"
systemctl start nginx   &>>  "${LOGFILE}"

 # $? tells the exit code of the last command
 # send the logs to temporary folder &>> this redirects the std.out and std.error 

echo -n "downloading the $COMPONENT :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "clearing the  default content :"
cd /usr/share/nginx/html
rm -rf *   &>> "${LOGFILE}"
stat $?

echo -n "Extracting $COMPONENT :" 
unzip /tmp/$COMPONENT.zip   &>> "${LOGFILE}"
stat $?

echo -n "Copying $COMPONENT :"
mv $COMPONENT-main/* .         &>> "${LOGFILE}"
mv static/* .                &>>  "${LOGFILE}"
rm -rf $COMPONENT-main README.md       &>> "${LOGFILE}"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

for component in catalogue cart user shipping payment; do
echo -n "Updating the backend reverse proxy dns records : "
sed -i -e "/$component/s/localhost/$component.roboshop.internal"  /etc/nginx/default.d/roboshop.conf
stat $?
done



echo -n "Restarting nginx :"
systemctl enable nginx  &>> "${LOGFILE}"
systemctl start nginx   &>>   "${LOGFILE}"

echo -e "\e[32m ______ $COMPONENT configuration completed_______\e[0m"
