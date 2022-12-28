#!/bin/bash
DATE="24-12-2022"
echo "good morning, today's date is $DATE"
DATE=$(date +%F)
echo "goodmorning todays date is $DATE"
echo "total no of opened sessions is $(who|wc -l)"