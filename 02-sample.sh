#!/bin/bash
# Escape Sequence Characters
# Escape sequence characters will be considered by echo command only if we enable it by using -e option
#
echo line1
echo line2
echo line3
# \n : new line
# \t : tab space
echo -e "line1\nline2\nline3\tdivya\t\t\tdevops"
echo -e "line1\nline2\tdivya"