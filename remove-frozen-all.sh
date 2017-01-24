#!/bin/sh

if [ -z $1 ];then
	echo "Please supply box_name as first parameter. then will remove all frozen boxes."
	exit 1
fi

box_name=$1
box_zero_frozen_name=__0__virtualbox__

 vagrant box list | grep '${box_name}' | grep '__0__virtualbox__' | awk '{print substr($3, 1, length($3)-1)}' \
	 | xargs -I{} vagrant box remove ${box_name} --provider ${box_zero_frozen_name} --box-version {}
