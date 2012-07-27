#!/bin/bash
# ThemeR Studio v2.0 by CorCor67
# v2.0 TheNeXGen

# PATHS
ts=~/ThemeR-Studio_V2
ws=$ts/Android

# Launch Android script from SDK so user can install platforms and tools.
clear
echo "A window will open for the Android SDK"
echo "Install platforms and tools from here or close it to continue."

cd $ws/android-sdk-linux/tools/
./android
