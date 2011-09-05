#!/bin/bash
# Backup & Restore Android Workspace v1.0
# By CorCor67
# v1.0 Original Release


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
    echo "Creating a backup of your theme space in ThemeR Studio folder..."	
7z a -mx9 /home/$USER/Desktop/ThemeRStudio/Backups/ThemeSpaceBackup.7z "/home/$USER/Android" ;;

#*********************************************************************


2 ) clear

echo "Extracting theme space backup from ThemeR Studio..." 	
7z x -o"/home/$USER" /home/$USER/Desktop/ThemeRStudio/Backups/ThemeSpaceBackup.7z ;;


#*********************************************************************

3 ) 
 clear
    echo "Creating a backup of your gradients in ThemeRStudio..."	
7z a -mx9 /home/$USER/Desktop/ThemeRStudio/Backups/GradientBackup.7z "/home/$USER/.gimp-2.6/gradients/*" ;;



4 ) clear

echo "Extracting to yout gradients folder..."	
7z e -o"/home/$USER/.gimp-2.6/gradients" /home/$USER/Desktop/ThemeRStudio/Backups/GradientBackup.7z ;;


5 ) clear

echo "Exporting backups to DropBox"
mkdir -p /home/$USER/Dropbox/ThemeRStudio-Backups
cp "/home/$USER/Desktop/ThemeRStudio/Backups/GradientBackup.7z" /home/$USER/Dropbox/ThemeRStudio-Backups
cp "/home/$USER/Desktop/ThemeRStudio/Backups/ThemeSpaceBackup.7z" /home/$USER/Dropbox/ThemeRStudio-Backups
;;

6 ) clear

echo "Importing backups from DropBox"
mkdir -p /home/$USER/ThemeRStudio/Backups
cp "/home/$USER/Dropbox/ThemeRStudio-Backups/GradientBackup.7z" /home/$USER/Desktop/ThemeRStudio-Backups
cp "/home/$USER/Dropbox/ThemeRStudio-Backups/ThemeSpaceBackup.7z" /home/$USER/Desktop/ThemeRStudio-Backups
;;



7 ) clear
firefox "http://db.tt/bHYl3J2"
sudo apt-get install dropbox
;;

8 ) clear
echo ""
echo ""
echo "You must have 7z installed for this script to work"
echo ""
echo ""
echo "Backups are placed in /home/$USER/Desktop/ThemeRStudio/Backups"
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


0 ) exit ;;
* ) echo "Please enter a number from the list above"
    esac
done
