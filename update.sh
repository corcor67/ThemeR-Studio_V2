#!/bin/bash
# ThemeR Studio v2.0 by CorCor67
# v2.0 TheNeXGen

# Paths
ts=~/ThemeR-Studio_V2
s=$ts/scripts

echo "Pulling updates from GitHub"
git pull
clear
echo "Extracting files"
echo ""
$s/workspace.sh

echo "Done"
sleep 3
