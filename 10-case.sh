#!/bin/bash
ACTION=$1

case $ACTION in
    start)
    echo "xyz service is starting"
    ;;
    stop)
    echo "xyz service is stopping"
    ;;
    restart)
    echo "xyz service is restarting"
    ;;
    *)
    echo -e "(\e[34m valid options are start or stop or restart only \e[0m )"
    esac