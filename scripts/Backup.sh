#!/bin/bash

# Backup & Restore Android Workspace v2.0
# by CorCor67
# v2.0 TheNeXGen

# Paths
ts=~/ThemeR-Studio_V2
db=~/Dropbox/ThemeR-Studio_V2-Backups
bu=$ts/Backups

selection=
until [ "$selection" = "0" ]; do
clear
    echo ""
    echo " ______________________________________________________________________ "
    echo " |                          Android ThemeR Studio                     | "
    echo " |____________________________ Backup & Restore_______________________| "
    echo " ====================================================================== "
    echo " ||  1 - Backup theme space                                          || "
    echo " ||  2 - Restore theme space                                         || "
    echo " ||  3 - Backup Gimp Gradients                                       || "
    echo " ||  4 - Restore Gimp Gradients                                      || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  5 - Export Backups to  DropBox                                  || "
    echo " ||  6 - Import Backups from DropBox                                 || "
    echo " ||                                                                  || "
    echo " ||  7 - Get DropBox                                                 || "
    echo " ||  8 - Help                                                        || "
    echo " ||                                                                  || "
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
echo "Creating a backup of your theme space in ThemeR-Studio folder..."	
7z a -mx9 $bu/ThemeSpaceBackup.7z "$ts"
;;
#*********************************************************************
2 )
clear
echo "Extracting theme space backup from ThemeR-Studio..." 	
7z x -o"$ts" $bu/ThemeSpaceBackup.7z
;;
#*********************************************************************
3 )
clear
echo "Creating a backup of your gradients in ThemeRStudio..."	
7z a -mx9 $bu/GradientBackup.7z "/home/$USER/.gimp-2.6/gradients/*"
;;
#*********************************************************************
4 )
clear
echo "Extracting to yout gradients folder..."	
7z e -o"/home/$USER/.gimp-2.6/gradients" $bu/GradientBackup.7z
;;
#*********************************************************************
5 )
clear
echo "Exporting backups to DropBox"
mkdir -p $db
cp "$bu/GradientBackup.7z" $db
cp "$bu/ThemeSpaceBackup.7z" $db
;;
#*********************************************************************
6 )
clear
echo "Importing backups from DropBox"
mkdir -p $db
cp "$db/GradientBackup.7z" $bu
cp "$db/ThemeSpaceBackup.7z" $bu
;;
#*********************************************************************
7 )
clear
firefox "http://db.tt/bHYl3J2"
sudo apt-get install dropbox
;;
#*********************************************************************
8 )
clear
echo ""
echo ""
echo "You must have 7z installed for this script to work"
echo ""
echo ""
echo "Backups are placed in $bu"
echo ""
echo ""
echo "In order for restore to work properly you need to have"
echo "the 7z in your ThemeRSetup's backup folder"
echo ""
echo ""
echo ""
echo ""
echo -n "Press enter when you're ready to move on."
    read selection
 ;;
#*********************************************************************
0 ) exit ;;
* ) echo "Please enter a number from the list above"
    esac
done
