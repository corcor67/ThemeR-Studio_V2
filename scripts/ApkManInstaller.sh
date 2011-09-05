#!/bin/bash
# ApkManager Install Script v1.0
# By CorCor67
# v1.0 Original Release

selection=
until [ "$selection" = "0" ]; do
clear
    echo ""
    echo " ______________________________________________________________________ "
    echo " |                          Android ThemeR Studio                     | "
    echo " |__________________________ApkManager  Installer_____________________| "
    echo " ====================================================================== "
    echo " ||  1 - Install Sox & JDK6 (Required for ApkManager)                || "
    echo " ||  2 - Install ApkManager                                          || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  3 - Help                                                        || "
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
1 ) clear
sudo apt-get update
sudo apt-get install sox
sudo apt-get install sun-java6-jdk ;;

#*********************************************************************
2 ) clear

# Extract zip to workspace
echo "Extracting ApkManager..."
mkdir -p /home/$USER/Android/ApkManager 
7z x -o"/home/$USER/Android/ApkManager" /home/$USER/Desktop/ThemeRStudio/scripts/apkmanager.7z  
;;

#*********************************************************************
3 ) clear
echo ""
echo ""
echo "You must have SoX and JDK6 installed for ApkManager to work"
echo ""
echo ""
echo "Run Options 1 then 2"
echo ""
echo ""
echo "ApkManager will be in /home/$USER/Android/ApkManager"
echo ""
echo ""
echo ""
echo ""
    echo -n "Press enter when you're ready to go back to the installer"
    read selection
 ;;

#*********************************************************************
0 ) exit ;;
* ) echo "Please enter a number from the list above"
    esac
done

