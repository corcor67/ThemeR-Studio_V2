#!/bin/bash
# ThemeR Studio v2.0 by CorCor67
# v2.0 TheNeXGen

# Paths
ts=~/ThemeR-Studio_V2
ws=$ts/Android

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
