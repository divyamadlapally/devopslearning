#!/bin/bash

a="XYZ"
if [ "$a"=="ABC" ];then
    echo -e "\e[35m both are equal \e[0m"
    exit 0

fi