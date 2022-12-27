#!/bin/bash
# Always fetch the information dynamically for the variable which keep on changing
Date="24-12-2022"
echo "good morning, today's date is $Date"
DATE=${date +%F}
echo todays date is ${DATE}