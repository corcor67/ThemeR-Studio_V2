#! /bin/sh
# Apk Manager 4.0 (C) 2010 by Daneshm90
# Ported to Linux by farmatito 2010
# Changelog for linux version:
# v 0.1 Initial version
# v 0.2 added "other" dir to PATH
# v 0.3 removed "function" bashism
# v 0.4 removed more bashisms
# v 0.5 added ogg batch optimization and quoted some vars


# Mods by CorCor67
# Added support for external tools for my ThemeR Studio scripts
# Now exports path to tools,  no more need to edit .bashrc
# Added support for user defined png optimization and zip compression,  also set defaults to 4

# v2.0 TheNeXGen - CorCor67
# Added more variables to trim down size
# Adjusted paths for new ThemeR-Studio tool locations


# PATHS
ts=~/ThemeR-Studio_V2
tools=$ts/.tools
am=$ts/Android/ApkManager

export PATH=$PATH:"$tools":"$am"

ap () {
	echo "Where do you want adb to pull the apk from? " 
	echo "Example of input : /system/app/launcher.apk"
	read INPUT
	APK_FILE=`basename $INPUT`
	adb pull "$INPUT" "place-apk-here-for-modding/$APK_FILE"
	if [ "$?" -ne "0" ] ; then
		echo "Error: while pulling $APK_FILE"
	fi
}

ex () {
	cd $tools
	rm -f "$am/place-apk-here-for-modding/repackaged.apk"
	rm -f "$am/place-apk-here-for-modding/repackaged-signed.apk"
	rm -f "$am/place-apk-here-for-modding/repackaged-unsigned.apk"
	rm -rf "$am/out"
	if [ ! -d "$am/out" ] ; then
		mkdir "$am/out"
	fi
	clear
	7za x -o"$am/out" $am/place-apk-here-for-modding/*.apk
	cd $am
}

opt () {
	cd $tools
	find "$am/out/res" -name *.png | while read PNG_FILE ;
	do
		if [ `echo "$PNG_FILE" | grep -c "\.9\.png$"` -eq 0 ] ; then
			optipng -o$opti "$PNG_FILE"
		fi
	done
	cd $am
}

sys () {
	cd $tools
	7za a -tzip "$am/place-apk-here-for-modding/repackaged-unsigned.apk" $am/out/* -mx$compression
	cd $am
}

oa () {
	rm -rf "out/META-INF"
	sys
}

zip () {
	clear
	echo "1    System  apk "
	echo "2    Regular apk "
	printf "%s" "Please make your decision: "
	read RETVAL
	if [ "x$RETVAL" = "x1" ] ; then
		sys
	elif [ "x$RETVAL" = "x2" ] ; then
		oa
	fi
}

si () {
	cd $tools
	INFILE="$am/place-apk-here-for-modding/repackaged-unsigned.apk"
	OUTFILE="$am/place-apk-here-for-modding/repackaged-signed.apk"
	if [ -e "$INFILE" ] ; then
		java -jar signapk.jar -w testkey.x509.pem testkey.pk8 "$INFILE" "$OUTFILE"
		if [ "x$?" = "x0" ] ; then
			rm "$INFILE"
			echo
		fi
	else
		echo "Warning: cannot find file '$INFILE'"
	fi
	cd $am
}

zipa () {
	for STRING in "signed" "unsigned"
	do
		if [ -e "place-apk-here-for-modding/repackaged-$STRING.apk" ] ; then
			zipalign -fv 4 "place-apk-here-for-modding/repackaged-$STRING.apk" "place-apk-here-for-modding/repackaged-$STRING-aligned.apk"
			if [ "x$?" = "x0" ] ; then
				mv -f "place-apk-here-for-modding/repackaged-$STRING-aligned.apk" "place-apk-here-for-modding/repackaged-$STRING.apk"
			fi
		else
			echo "zipalign: cannot find file 'place-apk-here-for-modding/repackaged-$STRING.apk'"
		fi
	done
}

ins () {
	sudo adb devices
	printf "%s" "Hit Enter to continue "
	read DUMMY
	adb install -r "place-apk-here-for-modding/repackaged-signed.apk"
}

alli () {
	clear
	echo "1    System  apk "
	echo "2    Regular apk "
	printf "%s" "Please make your decision: "
	read RETVAL
	if [ "x$RETVAL" = "x1" ] ; then
		sys
		si
		ins
	elif [ "x$RETVAL" = "x2" ] ; then
		oa
		si
		ins
	fi
}

apu () {
	echo "Where do you want adb to push to and as what name: "
	echo "Example of input : /system/app/launcher.apk "
	read INPUT
	sudo adb devices
	printf "%s" "Hit Enter to continue "
	read DUMMY
	adb remount
	adb push "place-apk-here-for-modding/repackaged-unsigned.apk" "$INPUT"
}
#-------------------------------------------------------------------------------------------------------------------------------Last of /home/$USER/Android/ApkManager
de () {
	cd $tools
	rm -f "$am/place-apk-here-for-modding/repackaged.apk"
	rm -f "$am/place-apk-here-for-modding/repackaged-signed.apk"
	rm -f "$am/place-apk-here-for-modding/repackaged-unsigned.apk"
	rm -rf "$am/out"
	rm -rf "out.out"
	clear
	java -jar apktool.jar d $am/place-apk-here-for-modding/*.apk "$am/out"
	cd $am
}

co () {
	cd $tools
	java -jar apktool.jar b "$am/out" "$am/place-apk-here-for-modding/repackaged-unsigned.apk"
	cd $am
}

all () {
	co
	si
	ins
}

bopt () {
	cd $tools
	mkdir -p "$am/place-apk-here-to-batch-optimize/original"
	find "$am/place-apk-here-to-batch-optimize" -name *.apk | while read APK_FILE ;
	do
		echo "Optimizing $APK_FILE"
		# Extract
		7za x -o"$am/place-apk-here-to-batch-optimize/original" "$am/place-apk-here-to-batch-optimize/$APK_FILE"
		# PNG
		find "$am/place-apk-here-to-batch-optimize/original" -name *.png | while read PNG_FILE ;
		do
			if [ `echo "$PNG_FILE" | grep -c "\.9\.png$"` -eq 0 ] ; then
				optipng -o$opti "$PNG_FILE"
			fi
		done
		# TODO optimize .ogg files
		# Re-compress
		7za a -tzip "$am/place-apk-here-to-batch-optimize/temp.zip" /$am/place-apk-here-to-batch-optimize/original/* -mx$compression
		FILE=`basename "$APK_FILE"`
		DIR=`dirname "$APK_FILE"`
		mv -f "$am/place-apk-here-to-batch-optimize/temp.zip" "$DIR/optimized-$FILE"
		rm -rf $am/place-apk-here-to-batch-optimize/original/*
	done
	rm -rf "$am/place-apk-here-to-batch-optimize/original"
	cd $am
}

asi () {
	cd $tools
	rm -f "$am/place-apk-here-for-signing/signed.apk"
	java -jar signapk.jar -w testkey.x509.pem testkey.pk8 $am/place-apk-here-for-signing/*.apk "$am/place-apk-here-for-signing/signed.apk"
	#clear
	cd $am
}

ogg () {
	cd $tools
	find "$am/place-ogg-here/" -name *.ogg | while read OGG_FILE ;
	do
		FILE=`basename "$OGG_FILE"`
		DIR=`dirname "$OGG_FILE"`
		printf "%s" "Optimizing: $FILE"
		sox "$OGG_FILE" -C 0 "$DIR/optimized-$FILE"
		if [ "x$?" = "x0" ] ; then
			printf "\n"
		else
			printf "...%s\n" "Failed"
		fi
	done
}

optimize () { clear
			echo "PNG optimization can be any number 0-7 note that higher optimization may distort your colors"
                echo -n "Please choose optimization level"
                echo ""
                read opti

case $opti in
           [0-7]) if [[ $opti -eq $opti ]]
           then
echo ""
           fi  ;;

           *) opti=4
echo "Invalid entry compression has been set to default" ;;
esac

}

compress () { clear
	echo "Compression can be any number 0-9 note that higher compression may cause issues"
                echo -n "Please choose compression level"
                echo ""
                read compression
case $compression in
           [0-9]) if [[ $compression -eq $compression ]]
           then
echo ""
           fi  ;;

           *) compression=4
echo "Invalid entry compression has been set to default" ;;
esac

}

quit () {
	exit 0
}

restart () {
	echo 
	echo "****************************** Apk Manager *******************************"
	echo "------------------Simple Tasks Such As Image Editing----------------------"
	echo "  0    Adb pull"
	echo "  1    Extract apk"
	echo "  2    Optimize images inside (Only if \"Extract Apk\" was selected)"
	echo "  3    Zip apk"
	echo "  4    Sign apk (Dont do this if its a system apk)"
	echo "  5    Zipalign apk (Do once apk is created/signed)"
	echo "  6    Install apk (Dont do this if system apk, do adb push)"
	echo "  7    Zip / Sign / Install apk (All in one step)"
	echo "  8    Adb push (Only for system apk)"
	echo "-----------------Advanced Tasks Such As Code Editing-----------------------"
	echo "  9    Decompile apk"
	echo "  10   Compile apk"
	echo "  11   Sign apk"
	echo "  12   Install apk"
	echo "  13   Compile apk / Sign apk / Install apk (All in one step)"
	echo "---------------------------------------------------------------------------"
	echo "  14   Batch Optimize Apk (inside place-apk-here-to-batch-optimize only)"
	echo "  15   Sign an apk        (inside place-apk-here-for-signing folder only)"
	echo "  16   Batch optimize ogg files (inside place-ogg-here only)"
        echo "  17   Change PNG Optimization                                (Currently:$opti)"
        echo "  18   Change Compression                                     (Currently:$compression)"
	echo "  19   Quit"
	echo "****************************************************************************"
	printf "%s" "Please make your decision: "
	read ANSWER

	case "$ANSWER" in
		 0)   ap ;;
		 1)   ex ;;
		 2)  opt ;;
		 3)  zip ;;
		 4)   si ;;
		 5) zipa ;;
		 6)  ins ;;
		 7) alli ;;
		 8)  apu ;;
		 9)   de ;;
		10)   co ;;
		11)   si ;;
		12)  ins ;;
		13)  all ;;
		14) bopt ;;
		15)  asi ;;
		16)  ogg ;;
		17) optimize ;;
                18) compress ;;
                19) quit ;;
		 *)
			echo "Unknown command: '$ANSWER'"
		;;
	esac
}

# Start
PATH="$PATH:$tools"
export PATH
# Test for needed programs and warn if missing
ERROR="0"
for PROGRAM in "optipng" "7za" "java" "sudo" "adb" "aapt" "sox"
do
	which "$PROGRAM" > /dev/null 
	if [ "x$?" = "x1" ] ; then
		ERROR="1"
		echo "The program $PROGRAM is missing or is not in your PATH,"
		echo "please install it or fix your PATH variable"
	fi
done
if [ "x$ERROR" = "x1" ] ; then
	exit 1
fi
if [ -z "$compression" ]
then
   compression="4"
fi
if [ -z "$opti" ]
then
   opti="4"
fi

clear
printf "%s" "Do you want to clean out all your current projects (y/N)? "
read INPUT
if [ "x$INPUT" = "xy" ] || [ "x$INPUT" = "xY" ] ; then
	rm -rf place-apk-here-for-modding
	rm -rf place-apk-here-for-signing
	rm -rf place-apk-here-to-batch-optimize
	rm -rf out
	rm -rf $HOME/apktool
	mkdir place-apk-here-for-modding
	mkdir place-apk-here-for-signing
	mkdir place-apk-here-to-batch-optimize
fi
while [ "1" = "1" ] ;
do
	restart
done
exit 0
