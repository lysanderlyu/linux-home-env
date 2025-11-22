#!/bin/bash

rbWin10=$(getent hosts rbWin10 | awk '{ print $1 }')
android156=$(getent hosts android156 | awk '{ print $1 }')
rbdebian=$(getent hosts rbdebian | awk '{ print $1 }')

android156_pass="realbom"
rbWin10_pass="856312"
mount_option="rw,uid=1000,gid=1000,mfsymlinks"
mount_option_lysander="rw,uid=1000,gid=1000,username=lysander,mfsymlinks"


testAndMountAndroid(){
        if ping android156 -W2 -c1 | grep -q '1 received' ;then
                echo "android156 is online,mounting it"
                if ! mount | grep -q "$Android156"; then
                        sudo mount -t cifs -o $mount_option,username=yclv,pass=$android156_pass //${android156}/work_yclv $Android156
                fi
                echo "android156 mount completely"
        fi
}

testAndMountRBDebian(){
        if ping rbdebian -W2 -c1 | grep -q '1 received' ;then
                echo "rbdebian is online,mounting it"
                if ! mount | grep -q "$RBDebian"; then
                        sudo mount -t cifs -o $mount_option,username=lysander,pass=$rbWin10_pass //${rbdebian}/Home $RBDebian
                fi
                echo "rbdebian mount completely"
        fi
}

testAndMountRBWin10(){
#	if ping rbWin10 -W2 -c1 | grep -q '1 received' ;then
		echo "rbWin10 is online,mounting"
		if ! mount | grep -q "$System"; then
			sudo mount -t cifs -o $mount_option_lysander,pass=$rbWin10_pass //${rbWin10}/System $System
		fi

		if ! mount | grep -q "$Learning"; then
			sudo mount -t cifs -o $mount_option_lysander,pass=$rbWin10_pass //${rbWin10}/Learning $Learning
		fi

		if ! mount | grep -q "$Other"; then
			sudo mount -t cifs -o $mount_option_lysander,pass=$rbWin10_pass //${rbWin10}/Other $Other
		fi

		if ! mount | grep -q "$Data"; then
			sudo mount -t cifs -o $mount_option_lysander,pass=$rbWin10_pass //${rbWin10}/Data $Data
		fi

		if ! mount | grep -q "$Wsl"; then
#			sudo mount -t cifs -o $mount_option_lysander,pass=$rbWin10_pass //${rbWin10}/GoogleDriver $GDriver
			sshfs -o allow_root,default_permissions -p 20222 lysander@${rbWin10}:/home/lysander $Wsl
		fi

		echo "rbWin10 mount completely"
#	fi
}
testAndMountAndroid
testAndMountRBDebian
#testAndMountRBWin10
