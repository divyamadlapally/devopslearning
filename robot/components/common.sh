LOGFILE=/tmp/$COMPONENT.log
APPUSER=roboshop

 ID=$(id -u)
 if [ $ID -ne 0 ] ; then
    echo -e "\e[31m You need to run the script either as a root user or with a sudo privilage \e[0m" 
    exit 1
 fi

stat() 
{
    if [ $1 -eq 0 ]; then 
       echo -e "\e[32m success \e[0m"
    else
        echo -e "\e[31m failure \e[0m"
    fi
}


PYTHON(){
    echo -n "Installing python3 and other dependencies : "
    yum install python36 gcc python3-devel -y     &>>  "${LOGFILE}"
    stat $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    USERID=$(id -u roboshop)
    GROUPID=$(id -g roboshop)
    
    echo -n "updating the UID and GID in the $COMPONENT.ini.file : "
    sed -i -e "/^uid/ c uid=${USERID}"  -e "/^gid/ c gid=${GROUPID}"  /home/$APPUSER/$COMPONENT/$COMPONENT.ini
    stat $?

    CONFIGURE_SERVICE
}



JAVA() {
    echo -n "Installing Maven : "
    yum install maven -y    &>>  "${LOGFILE}"
    stat $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    echo -n "Generating the artifact : "
    cd /home/$APPUSER/$COMPONENT/
    mvn clean package     &>>  "${LOGFILE}"
    mv target/$COMPONENT-1.0.jar $COMPONENT.jar
    
    CONFIGURE_SERVICE

    cd /home/$APPUSER/$COMPONENT/
    pip3 install -r requirements.txt     &>>  "${LOGFILE}"
    stat $?


}

NODEJS() {
    echo -n "Configuring nodejs repo : "
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -     &>> "${LOGFILE}"
    stat $?

    echo  -n "Installing nodejs : "
    yum install nodejs -y     &>> "${LOGFILE}"
    stat $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    NPM_INSTALL

    CONFIGURE_SERVICE
}

CREATE_USER() {
    id $APPUSER       &>>  "${LOGFILE}"
    if [ $? -ne 0 ] ; then
    echo -n "Creating Application User $APPUSER : "
    useradd $APPUSER      &>>  "${LOGFILE}"
    stat $?
fi
}

DOWNLOAD_AND_EXTRACT() {
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
}

NPM_INSTALL() {
    echo -n "Installing $COMPONENT Dependencies :"
    cd $COMPONENT
    npm install    &>>  "${LOGFILE}"
    stat $?
    
}
CONFIGURE_SERVICE() {
    echo -n "Configuring the $COMPONENT Service : "
    sed -i -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
    mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
    stat $?

    echo -n "Starting $COMPONENT Service : "
    systemctl daemon-reload      &>>  "${LOGFILE}"
    systemctl start $COMPONENT      &>>  "${LOGFILE}"
    systemctl enable $COMPONENT        &>>  "${LOGFILE}"
    stat $?


    echo -e "\e[32m_____$COMPONENT Configuration is completed______\e[0m"

}