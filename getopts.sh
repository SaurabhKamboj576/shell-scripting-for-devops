#!/bin/bash

while getopts "u:p:" option ; do
 case $option in 
  u) username=$OPTARG ;;
  p) password=$OPTARG ;;
  *) echo "invalid options"; exit 1 ;;
 esac
done
echo " Username : $username "
echo " password : $password "
