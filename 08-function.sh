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
    echo "number of opened sessions :"
    echo "todays date is:"
    echo "load average on the system in last 1 minute: $(uptime | awk -F : '{print $4}' | awk -F , '{print $1}')"
}