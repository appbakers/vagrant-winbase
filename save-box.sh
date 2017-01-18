
if [ "$1" = "" ];then
	echo Please supply parameter 1 as vagrant box fullname "(eg. USER/BOX_NAME or BOX_NAME)".
	exit 1
fi

box_name=$1

vagrant package --output ${box_name}.box --include ./scripts --vagrantfile ./_vagrant_win_Vagrantfile &&\
	vagrant box add ${box_name} ${box_name}.box

