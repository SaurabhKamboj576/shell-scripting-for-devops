#!/bin/bash
read -p "Enter your User Name and password " Name Password
if [ ${Name,,} != "saurabhkamboj576@gmail.com" ];then
 echo "Invalid Username "
elif [ $Password != "Kamboj@123" ]; then
 echo "password invalid"
else
 echo "Authentication Done!"
fi
