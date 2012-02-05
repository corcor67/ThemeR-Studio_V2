#!/bin/bash
# Edit Bash v2.0
# by CorCor67
# v2.0 TheNeXGen

clear
echo "You need to manually edit your .bashrc to include the paths for the Android SDK"
echo "Copy & paste the following 3 lines to the text editor that opened,  then go file>save"
echo ""
echo ""
echo "# Path for Android SDK"
echo 'export PATH=$PATH:~/ThemeR-Studio_V2/Android/android-sdk-linux/tools:~/ThemeR-Studio_V2/Android/android-sdk-linux_x86/platform-tools:~/bin'
echo ""
echo ""
gedit /home/$USER/.bashrc
echo "Press enter when you are done"
read enter
exit
