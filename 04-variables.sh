#!/bin/bash
# What is a variable?
# A variable is something which holds the value or data which would keep on changing as per situation or scenaario.
# Typically we are telling the computer/program that uses this variable when running the scripts
a=10
b=20
c=30
# How to print the variable
echo a 
#how to print the value of a
echo $a 
# If you dont declare a value and if you try to print it, it is going to considerr the value as null
echo value of a is $a 
echo value of a is ${a}
# $a and ${a} both are same
echo print the value of a : ${a}
echo print the value of d : ${d}
# export sends the value to the heep memory