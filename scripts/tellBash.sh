#!/bin/bash
# Edit Bash v1.0
# By CorCor67
# v1.0 Original Release

clear
echo "You need to manually edit your .bashrc to include the paths for the Android SDK"
echo "Copy & paste the following 3 lines to the text editor that opened,  then go file>save"
echo ""
echo ""
echo "# Path for Android SDK"
echo 'export PATH=$PATH:"/home/$USER/Android/android-sdk-linux_x86/tools:/home/$USER/Android/android-sdk-linux_x86/platform-tools'
echo ""
echo ""
gedit /home/$USER/.bashrc
echo "Press enter when you are done"
read enter
exit
