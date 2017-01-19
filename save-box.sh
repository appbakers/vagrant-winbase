#!/bin/bash

if [ "$1" = "" ];then
	echo Please supply parameter 1 as vagrant box fullname "(eg. USER/BOX_NAME or BOX_NAME)".
	exit 1
fi

box_name=$1

scrdir=$(dirname "$0")
echo "scrdir:: $scrdir"

tstamp() {
	echo $(date +%Y%m%d.%H%M%S)
}

cur_tstamp=$(tstamp)
box_zero_image_path=~/.vagrant.d/boxes/${box_name}/0/virtualbox
box_frozen_image_path=~/.vagrant.d/boxes/${box_name}/0/__0__virtualbox__
box_froze_existing_image_path=~/.vagrant.d/boxes/${box_name}/0.was.${cur_tstamp}/virtualbox
box_versioned_image_path=~/.vagrant.d/boxes/${box_name}/${cur_tstamp}/virtualbox
freeze_zero() {
	if [ ! -f $box_frozen_image_path ];then
		mv $box_zero_image_path $box_frozen_image_path
	fi
	#// manually created image to versioning...
	#// when user did not used this script but already box_zero was existed case,
	#// to negate conflict make versioning with 0.was.${cur_tstamp} 
	if [ -f $box_zero_image_path ];then
		mkdir -p $box_froze_existing_image_path
		mv $box_zero_image_path $box_froze_existing_image_path
	fi
}

versioned_boxadd() {
	freeze_zero
	vagrant box add ${box_name} ${box_name}.box &&\
		(mkdir -p $box_versioned_image_path; mv $box_zero_image_path $box_versioned_image_path)
}

vagrant package --output ${box_name}.box --include $scrdir/_scripts --vagrantfile $scrdir/_vagrant_win_Vagrantfile &&\
	versioned_boxadd


