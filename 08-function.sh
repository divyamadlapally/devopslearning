#!/bin/bash
# Declaring a sample function
# (paranthesis)
sample() {
    echo "I am a sample function"
    echo "If you want to call me, just type sample"
    echo "sample function is completed"
}
#calling the fucnction
sample
#calling the function second time
sample

stat() {
    echo "number of opened sessions : $(who | wc -l)"
    echo "todays date is: $(date +%F)"
    echo "load average on the system in last 1 minute: $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')"
}
#echo cualling stat function
stat