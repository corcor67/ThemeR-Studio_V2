#!/bin/bash
# ThemeR Studio v2.0 by CorCor67
# v2.0 TheNeXGen

echo "Downloading and installing dependencies required by ThemeR-Studio_V2"
      sudo yum install wget
      sudo yum install p7zip
      sudo yum install p7zip-plugins
      sudo yum install sox

# Get Java
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
wget http://download.oracle.com/otn-pub/java/jdk/6u31-b04/jdk-6u31-linux-x64-rpm.bin
chmod +x jdk-6u31-linux-x64-rpm.bin
sudo ./jdk-6u31-linux-x64-rpm.bin
rm jdk-6u31-linux-x64-rpm.bin
else
wget http://download.oracle.com/otn-pub/java/jdk/6u31-b04/jdk-6u31-linux-i586-rpm.bin
chmod +x jdk-6u31-linux-i586-rpm.bin
sudo ./jdk-6u31-linux-i586-rpm.bin
rm jdk-6u31-linux-i586-rpm.bin
fi
