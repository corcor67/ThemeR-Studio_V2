#!/bin/bash
# Edit Bash v2.0
# by CorCor67
# v2.0 TheNeXGen
b=~/.bashrc
c=~/.BU_bashrc
path='export PATH=$PATH:~s/ThemeR-Studio_V2/Android/android-sdk-linux/tools:~/ThemeR-Studio_V2/Android/android-sdk-linux/platform-tools:~/bin'


echo "Checking to see if you have an existing .bashrc"
	if [ -e "$b" ]
		then
			f=found
			echo "You do have an existing .bashrc"
		else
			f=not
			echo "We couldn't find a .bashrc so we'll make one."
			touch ~/.bashrc
	fi

echo "Checking if you alredy have ThemeR-Studio paths set up"

	if grep -Fxq "$path" ~/.bashrc
		then
			echo "You alredy have the correct paths!"
		else
			echo "Couldn't find the paths, no problem, we will add them."
if [ $f == found ]
then
			echo "Backing up current .bashrc as .BU_bashrc"
			cp $b $c
fi
			echo "Adding paths for ThemeR-Studio to .bashrc"
			echo $path >> $b
	fi

