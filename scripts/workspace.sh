#!/bin/bash
# ThemeR Studio v2.0 by CorCor67
# v2.0 TheNeXGen

# Paths
ts=~/ThemeR-Studio_V2
s=$ts/scripts
tools=$ts/.tools
ws=$ts/Android

# Setup Directories
echo "Creating Android workspace..." 
     mkdir -p $ws
     mkdir -p $ws/ThemeR-Studio
     mkdir -p $ws/ApkManager
7z x -o"$ts" $s/tools.7z
cd $tools  
chmod u+rwx *

# Setup ApkManager
cp "$s/ApkManager.sh" $ws/ApkManager
cp "$s/ApkManagerICS.sh" $ws/ApkManager
cp "$s/ThemeR-Studio.sh" $ws/ThemeR-Studio

mkdir -p $ts/.sdkDL
cd $ts/.sdkDL
      var_links=`wget -q -L -O - \
       http://developer.android.com/sdk/index.html \
       | grep -o 'http://dl.google.com/android/android-sdk[^"]*linux.tgz' \
       | sed -e 's/<a href=\"//' -e 's/\"/\n/'`
    wget --spider $var_links
    wget $var_links 
tar xvzf $ts/.sdkDL/*tgz -C "$ws"
rm -rf $ts/.sdkDL
