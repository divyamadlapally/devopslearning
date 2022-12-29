#!/bin/bash


a="xyz"

if [ "$a" == "ABC" ]; then
    echo -e "\e[35m both are equal \e[0m"
    

fi

#If else condition
if [ "$a" == "ABC" ]; then
    echo -e "\e[34m both are equal \e[0m"
    exit 0
else
    echo -e "\e[34m  both are not equal \e[0m"
    exit 1

fi

#note : use == when you are dealing with strings, use -eq when dealing with numbers.

b="$1"
if [ "$b" -eq "10" ]; then
   echo "value is b 10"
elif [ "$b" -eq "20" ]; then
   echo "value is b 20"
elif [ "$b" -eq "30" ]; then
   echo "value is b 30"

else
   echo "value is not 10 or 20 or 30"

fi