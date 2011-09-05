#!/bin/bash
# Themer Program Installer Script v1.0
# By CorCor67
# v1.0 Original Release

echo "Updating repos..."
sudo apt-get update

selection=
until [ "$selection" = "0" ]; do
clear
    echo ""
    echo " ______________________________________________________________________ "
    echo " |                          Android ThemeR Studio                     | "
    echo " |______________________________Downloads Menu________________________| "
    echo " ====================================================================== "
    echo " ||  1 - Install 7z                                                  || "
    echo " ||  2 - Install SoX                                                 || "
    echo " ||  3 - Install JDK6                                                || "
    echo " ||  4 - Install SDK ------------------- (MUST BUILD WORKSPACE FIRST)|| "
    echo " ||  5 - Install Eclipse                                             || "
    echo " ||  6 - All of the above                                            || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||                                                                  || "
    echo " ||  7 - Help                                                        || "
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
    echo "Installing 7z..."
    sudo apt-get install 7z ;;
2 ) clear
    echo "Installing SoX..."
    sudo apt-get install sox ;;
3 ) clear
    echo "Installing JDK6..."
    sudo apt-get install sun-java6-jdk ;;
4 ) clear
    echo "Installing Android SDK..."
# Setting up download directory and removing any previous files that might be in there
rm /home/$USER/Desktop/ThemeRStudio/.sdkDL/*
mkdir -p /home/$USER/Desktop/ThemeRStudio/.sdkDL
cd /home/$USER/Desktop/ThemeRStudio/.sdkDL

# looks for download links for linux SDK on SDK download page without looking for a specific version
      var_links=`wget -q -L -O - \
       http://developer.android.com/sdk/index.html \
       | grep -o 'http://dl.google.com/android/android-sdk[^"]*linux_x86.tgz' \
       | sed -e 's/<a href=\"//' -e 's/\"/\n/'`

    wget --spider $var_links

# Downloads linux version of the SDK

    wget $var_links
# Unpacks to 
tar xvzf /home/$USER/Desktop/ThemeRStudio/.sdkDL/*tgz -C /home/$USER/Android
clear
# Have user manually edit in path for SDK
    gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/tellBash.sh && exit ; bash"

     ;;

5 ) clear
    echo "Installing Eclipse..."
    sudo apt-get install eclipse ;;
6 ) clear
     echo "Installing all..."
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
tar xvzf /home/$USER/Desktop/ThemeRStudio/.sdkDL/*tgz -C /home/$USER/Android
clear
# Have user manually edit in path for SDK
    gnome-terminal  --execute bash -c "cd /home/$USER/Desktop/ThemeRStudio/scripts && /home/$USER/Desktop/ThemeRStudio/scripts/tellBash.sh && exit ; bash"
 ;;


#*********************************************************************

7 ) clear
echo ""
echo ""
echo "7z is required by these scripts to complete some actions"
echo "SoX is required by ApkManager"
echo "JDK6 is required for ApkManager and Eclipse"
echo "The Android SDK is needed to build applications for Android"
echo "Eclipse is a program used to build applications"
echo ""
echo ""
echo ""
echo ""
echo "I may add an option to remove some of these after installed"
echo ""
echo ""
echo -n "Press enter when you're ready to return to the downloads menu"
read selection

 ;;


0 ) exit ;;
* ) echo "Please enter a number from the list above"
    esac
done
