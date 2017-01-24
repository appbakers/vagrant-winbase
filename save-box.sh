#!/bin/bash

if [ "$1" = "" ];then
	echo Please supply parameter 1 as vagrant box fullname "(eg. USER/BOX_NAME or BOX_NAME)".
	exit 1
fi

box_name=$1
reuse=N # when failed to box add stage, then set this option to retry again with the box
if [ "$2" = "--reuse" ];then
	echo "--reuse ==> reuse=Y"
	reuse=Y
fi

scrdir=$(dirname "$0")
echo "scrdir:: $scrdir"

tstamp() {
	echo $(date +%Y%m%d.%H%M%S)
}
parent_dir() {
	echo $(dirname "$1")
}

cur_tstamp=$(tstamp)
box_zero_image_path=~/.vagrant.d/boxes/${box_name}/0/virtualbox
box_frozen_image_path=~/.vagrant.d/boxes/${box_name}/0.was.${cur_tstamp}/__virtualbox__
freeze_zero() {
	if [ -d $box_zero_image_path ];then
		mv -v $box_zero_image_path $(parent_dir "${box_frozen_image_path}")
	fi
}

versioned_boxadd() {
	freeze_zero
	vagrant box add ${box_name} ${box_name}.box
}

if [ "$reuse" = "Y" ];then
	versioned_boxadd
else
	vagrant package --output ${box_name}.box --include $scrdir/_scripts --vagrantfile $scrdir/_vagrant_win_Vagrantfile &&\
		versioned_boxadd
fi

