#!/bin/bash
#Author :jl8722@ic.ac.uk
#script: csvtospace.sh
#Description: subtitute the commas in the files with spaces
#Save the output into a new txt file
#Date: Oct 2022


echo "there is a comma delimited version of $1"   #mention the goal file
cat $1 |tr -s "," " " >> ${1%.*}.txt                 # command 'cat' print file on the screen, 'tr -s' transfer all ',' to 'space' , then '>>' store in a 
echo  "Finish"
exit

