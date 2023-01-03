#!/bin/bashfor loop will be used, when the loop is based on inputs
#

for list in val1 val2 val3 val4 val5 ; do
    echo value is $list
done

for courses in devops aws azzure docker jenkins kubernetes ; do
       echo course name is $courses
done

# while loop : a conditional loop

val=0
while [ $val -lt 10 ]; do
  echo I = $val
  i=$(($val+1))
  done