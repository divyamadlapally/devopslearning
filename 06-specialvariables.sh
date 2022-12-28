#!/bin/bash
# Special variables are pre defined, which means you cannot create them, you can only use thhem
# Here are few of the special variables

### $0 : prints the script name
$? : shows the exit code of the previous command
$0 to $9 : command line variables
$* or $@ : prints all the variables used in this script
$# : prints the no of varibles used in this script
echo name of the script is $0
echo variables used in this script are $*
echo no of variables used in this script are $#
a=$1
b=$2
echo value of a is $a  