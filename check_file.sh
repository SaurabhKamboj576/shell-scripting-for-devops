#!/bin/bash

read -p "Enter the path of the file : " path

if [ -f $path ];then
 echo " it is a file "
elif [ -d $path ]; then 
 echo "it is a directory" 
else 
 echo "file didn't exit"

fi
