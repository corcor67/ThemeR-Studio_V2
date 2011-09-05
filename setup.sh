#!/bin/bash
# ThemeR Studio v1.0 (C) 2011 CorCor67
# v1.0 Initial Release
# Notice:  You are welcome to modify these scripts as you see fit,  I only ask that you keep credits to the original authors in tact.  I put a lot of work into getting these where they are and im sure the authors of ApkManager and ApkOpt both did too.  In the credits section I have included a few ways to contact me,  I would love to see any changes or improvements you might have.

selection=
until [ "$selection" = "0" ]; do
clear
    echo ""
    echo " ______________________________________________________________________ "
    echo " |                          Android ThemeR Studio                     | "
    echo " |_______________________________Main  Menu___________________________| "
    echo " ====================================================================== "
    echo " ||  1 - Setup tools                      (Run First and only once)  || "
    echo " ||  2 - Download Menu              (Programs that may be required)  || "
    echo " ||  3 - Build your workspace                                        || "
    echo " ||  4 - Install ApkManager                                          || "
    echo " ||  5 - Backup & Restore Menu                                       || "
    echo " ||  6 - Set up Theme Engine  (THIS IS NOT DONE IN AUTO EVERYTHING)  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  7 - AUTO SETUP EVERYTHING                        (Runs 1,2,3,&4)|| "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  8 - Extras Menu                                                 || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  9 - Help                                                        || "
    echo " ||  0 - Exit Menu                                                   || "
    echo " ====================================================================== "
    echo ""
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in
#*********************************************************************
#*********************************************************************
1 ) 
7z x -o"/home/$USER/" /home/$USER/Desktop/ThemeRStudio/scripts/Toolz.7z  
chmod u+rwx /home/$USER/.ThemeRStudioToolz/*
;;
#*********************************************************************
#*********************************************************************
2 ) clear
{
    gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/DownloadMenu.sh && exit ; bash" 
}
;;
#*********************************************************************
#*********************************************************************
3 )  clear
     echo "Creating Android workspace..." 
     mkdir -p /home/$USER/Android
     mkdir -p /home/$USER/Android/ApkManager
     mkdir -p /home/$USER/Android/apkopt
     mkdir -p /home/$USER/Android/ROMs
     mkdir -p /home/$USER/Android/ThemeProjects
     mkdir -p /home/$USER/Android/ThemeSource
   cp "/home/$USER/Desktop/ThemeRStudio/scripts/apkopt.sh" /home/$USER/Android/apkopt

 ;;
#*********************************************************************
#*********************************************************************
4 ) clear
    gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/ApkManInstaller.sh && exit ; bash"
    ;;
#*********************************************************************
#*********************************************************************
5 ) clear
    gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/Backup.sh && exit ; bash"
 ;;
#*********************************************************************
#*********************************************************************
6 ) clear
# Detect if user has 32 or 64 bit sys and launches the appropriate script & removes the other
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/ThemeEngine64.sh && exit ; bash"
rm "/home/$USER/Desktop/ThemeRStudio/scripts/ThemeEngine32.sh"
else
gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/ThemeEngine32.sh && exit ; bash"
rm "/home/$USER/Desktop/ThemeRStudio/scripts/ThemeEngine64.sh"
fi
;;
#*********************************************************************
#*********************************************************************
7 ) clear

7z x -o"/home/$USER/" /home/$USER/Desktop/ThemeRStudio/scripts/Toolz.7z  
chmod u+rwx /home/$USER/.ThemeRStudioToolz/*

# Install Programs
echo "Downloading and installing 7z, SoX, JDK 6, Android SDK, and Eclipse..."
      sudo apt-get update
      sudo apt-get install 7z
      sudo apt-get install sox
      sudo apt-get install sun-java6-jdk
      sudo apt-get install eclipse
rm /home/$USER/Desktop/ThemeRStudio/.sdkDL/*
mkdir -p /home/$USER/Desktop/ThemeRStudio/.sdkDL
cd /home/$USER/Desktop/ThemeRStudio/.sdkDL
      var_links=`wget -q -L -O - \
       http://developer.android.com/sdk/index.html \
       | grep -o 'http://dl.google.com/android/android-sdk[^"]*linux_x86.tgz' \
       | sed -e 's/<a href=\"//' -e 's/\"/\n/'`
    wget --spider $var_links
    wget $var_links 
tar xvzf /home/$USER/Desktop/ThemeRStudio/.sdkDL/*tgz -C "/home/$USER/Android/"
# Have user manually edit in path for SDK
    gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/tellBash.sh && exit ; bash" 

# Setup Directories
echo "Creating Android workspace..." 
     mkdir /home/$USER/Android
     mkdir /home/$USER/Android/ApkManager
     mkdir /home/$USER/Android/apkopt
     mkdir /home/$USER/Android/ROMs
     mkdir /home/$USER/Android/ThemeProjects
     mkdir /home/$USER/Android/ThemeSource

# Setup apkopt
       cp "/home/$USER/Desktop/ThemeRStudio/scripts/apkopt.sh" /home/$USER/Android/apkopt

# Setup ApkManager
echo "Extracting ApkManager..."
mkdir -p /home/$USER/Android/ApkManager 
7z x -o"/home/$USER/Android/ApkManager" /home/$USER/Desktop/ThemeRStudio/scripts/apkmanager.7z  
       export PATH=$PATH:"/home/$USER/.ThemeRStudioToolz"
     echo "Setting Permissions..."
       chmod u+rwx /home/$USER/Android/ApkManager/Script.sh
       chmod u+rwx /home/$USER/.ThemeRStudioToolz/*
 ;;
#*********************************************************************
#*********************************************************************
8 ) clear
{
    gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/extras.sh && exit ; bash" 
}
;;
#*********************************************************************
#*********************************************************************
9 )
echo "1- Sets up tools in home/$USER/.ThemerStudioToolz these tools are used by apkmanager and apkopt,  if you don't use either you don't need them"
echo ""
echo "2- A group of programs needed for these scripts and some of the scripts included"
echo ""
echo "3- Sets up a few folders to help you keep organized,  these folders are not needed and you may delete them if you don't want them.  The backup feature zips up everything in /home/$USER/Android/ so leave that one in place if you want to backup."
echo ""
echo "4- Installs ApkManager to /home/$USER/Android/ApkManager I have modified the script so that you don't need to add paths."
echo ""
echo "5- Backs up /home/$USER/Android/ and also your custom made Gimp gradients.  There is an option to export your backups to dropbox.  Also imports backups from dropbox,  and restores backups.  Great if you have multiple computers you work on or are planning on formatting your hard drive."
echo ""
echo "6- Theme Engine is a work in progress,  it downloads everything you need but isn't fully functioning yet.  Once I get it working right I'll push out an update for it.  Please remember it doesn't fully work yet!"
echo ""
echo "7- Sets up & installs everything,  doesn't do Theme Engine as it is broke at this time"
echo ""
echo "8- Extras Menu has links to report any bugs you may find,  places to find the original apkopt and apkmanager scripts used here,  and a credits list."
echo ""
echo "Press enter when you're ready to go back to the menu"
read enter
;;
#*********************************************************************
#*********************************************************************
0 ) exit ;;
* ) echo "Please enter a number from the list above"
    esac
done

