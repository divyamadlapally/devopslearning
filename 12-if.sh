#!/bin/bash

a="xyz"
if [ "$a"=="ABC" ]; then
    echo -e "\e[35m both are equal \e[0m"
    

fi

#If else condition
if [ "$a"=="ABC" ]; then
    echo -e "\e[34m both are equal \e[0m"
    exit 0
else
    echo -e "\e[34m  both are not equal \e[0m"
    exit 1

fi