#!/bin/bash
COMPONENT=cart

source components/common.sh

echo -n "Configuring nodejs repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -     &>> "${LOGFILE}"
stat $?

echo  -n "Installing nodejs : "
yum install nodejs -y     &>> "${LOGFILE}"
stat $?

id $APPUSER       &>>  "${LOGFILE}"
if [ $? -ne 0 ] ; then
    echo -n "Creating Application User $APPUSER : "
    useradd $APPUSER      &>>  "${LOGFILE}"
    stat $?
fi
echo -n "Downloading the $COMPONENT : "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Cleanup and Extracting the $COMPONENT : "
rm -rf /home/$APPUSER/$COMPONENT/
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip    &>>  "${LOGFILE}"
stat $?

echo -n "Changing the ownership to $APPUSER"
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
stat $?

echo -n "Installing $COMPONENT Dependencies :"
cd $COMPONENT
npm install    &>>  "${LOGFILE}"
stat $?

echo -n "Configuring the $COMPONENT Service : "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?

echo -n "Starting $COMPONENT Service : "
systemctl daemon-reload      &>>  "${LOGFILE}"
systemctl start $COMPONENT      &>>  "${LOGFILE}"
systemctl enable $COMPONENT        &>>  "${LOGFILE}"
stat $?


echo -e "\e[32m_____$COMPONENT Configuration is completed______\e[0m"


