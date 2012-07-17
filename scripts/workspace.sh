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
rm -rf $tools
7z x -o"$ts" $s/tools.7z
cd $tools  
chmod u+rwx *

# Setup ApkManager
cp "$s/ApkManager.sh" $ws/ApkManager
cp "$s/ApkManagerICS.sh" $ws/ApkManager
cp "$s/ThemeR-Studio.sh" $ws/ThemeR-Studio
