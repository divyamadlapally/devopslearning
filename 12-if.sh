#!/bin/bash

a="ABC"
if [ "$a"=="ABC" ]; then
    echo -e "\e[32m both are equal \e[0m"

    fi

#if else

if  [ "$a"=="ABC" ]; then
echo -e "\e[32m both are equal \e[0m"
else
echo -e "\e[32m both are not equal \e[0m"

fi

#note : use == when you are dealing with strings, use -eq when dealing with numbers.

b=$1
if [ "$b" -eq "10" ]; then
   echo "value is b 10"
elif [ "$b" -eq "20" ]; then
   echo "value is b 20"
elif [ "$b" -eq "30" ]; then
   echo "value is b 30"

else
   echo "value is not 10 or 20 or 30"

fi