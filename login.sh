#!/bin/bash

cat << END
Welcome to Crushlinux Studio
CentOS release 7.5 (1804)
Kernel 3.10.0 on an x86_64

END

read -p "localhost login: " user
if [ $user == "root" ]
then
	echo "欢迎管理$user回家"
else	
	echo "你是哪儿来的鬼?"
fi
