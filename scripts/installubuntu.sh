#!/bin/bash
# ThemeR Studio v2.0 by CorCor67
# v2.0 TheNeXGen

# Test for needed programs and install any missing
clear
echo "Your password is required to update apt and install"
echo "any missing programs"

sudo apt-get update

clear
echo "*** Checking for 7zip"
type 7z >/dev/null 2>&1 || { echo >&2 "Didn't find 7zip, attempting to install..."; sudo apt-get install p7zip-full; }

echo "*** Checking for sox"
type sox >/dev/null 2>&1 || { echo >&2 "Didn't find sox, attempting to install..."; sudo apt-get install sox; }

echo "*** Checking for java"
type java >/dev/null 2>&1 || { echo >&2 "Didn't find java, attempting to install..."; sudo apt-get install java; }
