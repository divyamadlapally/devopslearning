#!/bin/bash
ACTION=$1

case $ACTION in
    start)
    echo "xyz service is starting"
    exit 0
    ;;
    stop)
    echo "xyz service is stopping"
    exit 0
    ;;
    restart)
    echo "xyz service is restarting"
    exit 0
    ;;
    *)
    echo -e "(\e[34m valid options are start or stop or restart only \e[0m )"
    exit 1
    esac