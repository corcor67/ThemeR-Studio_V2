#!/bin/bash

# ThemeEngine64 v2.0
# by CorCor67
# v2.0 TheNeXGen

# A script to pull in and setup source code to compile a Theme Engine theme on 64bit machines.

# PATHS
ts=~/ThemeR-Studio_V2
ws=$ts/Android/ThemeEngine

selection=
until [ "$selection" = "0" ]; do
clear
    echo ""
    echo " ______________________________________________________________________ "
    echo " |                          Android ThemeR Studio    *64bit version*  | "
    echo " |_______________________________Theme Engine_________________________| "
    echo " ====================================================================== "
    echo " ||  1 - Download Programs Needed                                    || "
    echo " ||  2 - Reboot ----------> (Needs done after step 1 & before Step 3)|| "
    echo " ||  3 - Setup Workspace & sync repos                                || "
    echo " ||  4 - Compile                                                     || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  5 - Help                                                        || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  0 - Exit Menu                                                   || "
    echo " ====================================================================== "
    echo ""
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in

#*********************************************************************
1 )
clear
echo "Installing programs..."
sudo apt-get update
sudo apt-get install git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.6-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev sun-java6-jdk pngcrush schedtool g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline5-dev gcc-4.3-multilib g++-4.3-multilib
mkdir -p "/home/$USER/bin"
curl "http://android.git.kernel.org/repo" > "/home/$USER/bin/repo"
chmod u+rwx "/home/$USER/bin/repo"
;;
#*********************************************************************
2 )
clear 
sudo reboot
;;
#*********************************************************************
3 ) clear
mkdir -p "$ws"
cd "$ws"
repo init -u git://github.com/tmobile/themes-platform-manifest.git -b master
repo sync
mkdir -p "$ws/vendor/tmobile/themes"
cd "$ws/vendor/tmobile/themes"
git clone git@github.com:corcor67/Templatebread.git
;;
#*********************************************************************
4 )
clear
cd $ws
source build/envsetup.sh
lunch themes_generic-eng hdpi
make -j`grep 'processor' /proc/cpuinfo | wc -l`
;;
#*********************************************************************
5 )
clear
firefox "http://code.google.com/p/android-theme/wiki/TMobileThemeEngine"
;;
#*********************************************************************
0 ) exit ;;
* ) echo "Please enter a number from the list above"
    esac
done
