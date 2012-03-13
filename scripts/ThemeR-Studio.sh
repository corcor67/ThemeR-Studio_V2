#! /bin/sh
# Apk Manager 4.0 (C) 2010 by Daneshm90
# Ported to Linux by farmatito 2010
# Changelog for linux version:
# v 0.1 Initial version
# v 0.2 added "other" dir to PATH
# v 0.3 removed "function" bashism
# v 0.4 removed more bashisms
# v 0.5 added ogg batch optimization and quoted some vars

# Forked By CorCor67 for ThemeR-Studio_V2

# v 2.0 Initial Fork
# Added support for ThemeR-Studio's universal tool set
# Exports path to tools,  no more need to edit .bashrc
# Added support for user defined png optimization and zip compression,  also set defaults to 4
# Added more variables to trim down size
# Added support to copy frameworks to apktool
# Added option to clean folders into main script & removed initial prompt to clean them
# Removed the check for sox as well as options to optimize .ogg files
# Added batch decompile
# Added batch compile
# Added batch zipalign
# Added support for decompiling and compiling Ice Cream Sandwich
# Added Batch Operations Menu

# path variables
ts=~/ThemeR-Studio_V2
tools=$ts/.tools
am=$ts/Android/ThemeR-Studio
ca=$am/batch-compiled-apks
da=$am/batch-decompiled-apks
pam="$am/place-apk-here-for-modding"
bo=$am/place-apk-here-to-batch-optimize
rom=$am/place-rom-here
fw=$rom/decompressed/system/framework
app=$rom/decompressed/system/app
# export path
export PATH=$PATH:"$tools":"$am"

ap () {
	echo "Where do you want adb to pull the apk from?" 
	echo "Example of input : /system/app/launcher.apk"
	read INPUT
	APK_FILE=`basename $INPUT`
	adb pull "$INPUT" "$pam/$APK_FILE"
	if [ "$?" -ne "0" ] ; then
		echo "Error: while pulling $APK_FILE"
	fi
}

ex () {
	cd $tools
	rm -f "$pam/repackaged.apk"
	rm -f "$pam/repackaged-signed.apk"
	rm -f "$pam/repackaged-unsigned.apk"
	rm -rf "$am/out"
	if [ ! -d "$am/out" ] ; then
		mkdir "$am/out"
	fi
	clear
	7za x -o"$am/out" $am/$pam/*.apk
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
	7za a -tzip "$pam/repackaged-unsigned.apk" $am/out/* -mx$compression
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
	INFILE="$pam/repackaged-unsigned.apk"
	OUTFILE="$pam/repackaged-signed.apk"
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
		if [ -e "$pam/repackaged-$STRING.apk" ] ; then
			zipalign -fv 4 "$pam/repackaged-$STRING.apk" "$pam/repackaged-$STRING-aligned.apk"
			if [ "x$?" = "x0" ] ; then
				mv -f "$pam/repackaged-$STRING-aligned.apk" "$pam/repackaged-$STRING.apk"
			fi
		else
			echo "zipalign: cannot find file $pam/repackaged-$STRING.apk"
		fi
	done
}

apu () {
	echo "Where do you want adb to push to and as what name: "
	echo "Example of input : /system/app/launcher.apk "
	read INPUT
	sudo adb devices
	printf "%s" "Hit Enter to continue "
	read DUMMY
	adb remount
	adb push "$pam/repackaged-unsigned.apk" "$INPUT"
}
#-------------------------------------------------------------------------------------------------------------------------------Last of /home/$USER/Android/ApkManager
de () {
	cd $tools
	rm -f "$pam/repackaged.apk"
	rm -f "$pam/repackaged-signed.apk"
	rm -f "$pam/repackaged-unsigned.apk"
	rm -rf "$am/out"
	rm -rf "out.out"
	clear
	java -jar apktool1.4.2.jar d $pam/*.apk "$am/out"
	cd $am
}

co () {
	cd $tools
	java -jar apktool1.4.3.jar b "$am/out" "$pam/repackaged-unsigned.apk"
	cd $am
}

all () {
	co
	si
}

bopt () {
	cd $tools
	mkdir -p "$bo/original"
	find "$bo" -name *.apk | while read APK_FILE ;
	do
		echo "Optimizing $APK_FILE"
		# Extract
		7za x -o"$bo/original" "$bo/$APK_FILE"
		# PNG
		find "$bo/original" -name *.png | while read PNG_FILE ;
		do
			if [ `echo "$PNG_FILE" | grep -c "\.9\.png$"` -eq 0 ] ; then
				optipng -o$opti "$PNG_FILE"
			fi
		done
		# TODO optimize .ogg files
		# Re-compress
		7za a -tzip "$bo/temp.zip" $bo/original/* -mx$compression
		FILE=`basename "$APK_FILE"`
		DIR=`dirname "$APK_FILE"`
		mv -f "$bo/temp.zip" "$DIR/optimized-$FILE"
		rm -rf $bo/original/*
	done
	rm -rf "$bo/original"
	cd $am
}

tt () {
	clear
	echo "1    Adjust Optipng Compression "
	echo "2    Adjust Zip Compression "
	printf "%s" "Please make your decision: "
	read RETVAL
	if [ "x$RETVAL" = "x1" ] ; then
		op
	elif [ "x$RETVAL" = "x2" ] ; then
		com
	fi
}

op () { clear
		echo "PNG optimization can be any number 0-7 note that higher optimization may distort your colors"
		echo "current level is set to $opti"
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

# Begin batch ops

###Batch Decompile###

bde () {
fw
rm -rf $da
mkdir -p $da
# /system/app
cd $app
for apks in $(find . -name "*.apk")
do
echo "$apks"
cd $tools
java -jar apktool1.4.2.jar d $app/$apks $da/"`basename $apks .apk`"
done

# /frameworks
cd $fw
for apks in $(find . -name "*.apk")
do
echo $apks
cd $tools
java -jar apktool1.4.2.jar d $fw/$apks $da/"`basename $apks .apk`"
done
cd $am
}

###Batch Compile###

bco () {
rm -rf $ca
mkdir -p $ca
cd $da
for dirs in *
do
cd $tools
java -jar apktool1.4.3.jar b "$dirs" "$ca/$dirs.apk"
done
cd $am
}

###Batch Zipalign###

bza () {

cd $ca
mkdir -p original_apks
mkdir -p optimized_apks
	for a in *.apk
	do
echo "Zipalign is working on $a"
cp $a original_apks/$a
			zipalign -fv 4 $a optimized_apks/$a
#rm $a
	done
}

# End batch ops

fw () { clear 
	mkdir -p ~/apktool/framework/
	rm -rf $rom/decompressed
	7z x -o"$rom/decompressed" $rom/*.zip
	cd $rom/decompressed/system/framework
	rm -rf ~/apktool/frameworks/*
	cp "framework-res.apk" ~/apktool/framework/1.apk
#	rm $rom/decompressed/system/framework/framework-res.apk
# Find any third party frameworks
	for apk in $(find . -name "com.*.apk"); do
		cp "${apk}" ~/apktool/framework/2.apk
done


}

com () { clear
	echo "Compression can be any number 0-9 note that higher compression may cause issues."
		echo "current level is set to $compression"
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

cf () { clear
echo "WARNING, cleaning folders will result in the removal of all"
echo "content within the following folders..."
echo ""
echo "/batch-compiled-apks"
echo "/batch-decompiled-apks"
echo "/place-apk-here-for-modding"
echo "/place-apk-here-to-batch-optimize"
echo "/place-rom-here"
echo "/out"
echo ""
printf "%s" "Are you sure you want to do this? (y/n)"
read INPUT
if [ "x$INPUT" = "xy" ] || [ "x$INPUT" = "xY" ] ; then
	rm -rf $ca
	rm -rf $da
	rm -rf $pam
	rm -rf $bo
	rm -rf $rom
	rm -rf out
	mkdir -p $pam
	mkdir -p $bo
	mkdir -p $rom
fi

}

quit () {
	exit 0
}

restart () {
clear
	echo "**************************** ThemeR-Studio_V2 *****************************"
	echo "*  1    Adb pull                                                          *"
	echo "*  2    Extract apk                                                       *"
	echo "*  3    Optimize images inside (Only if \"Extract Apk\" was selected)     *"
	echo "*  4    Zip apk                                                           *"
	echo "*  5    Sign apk (Dont do this if its a system apk)                       *"
	echo "*  6    Zipalign apk (Do once apk is created/signed)                      *"
	echo "*  7    Adb push (Only for system apk)                                    *"
	echo "*  8    Decompile apk                                                     *"
	echo "*  9    Compile apk                                                       *"
	echo "*  10   Sign apk                                                          *"
	echo "*  11   Compile apk / Sign apk / Install apk (All in one step)            *"
	echo "*  12   Batch Optimize Apk (inside place-apk-here-to-batch-optimize only) *"
	echo "*  13   Tool Tweaks - (Optipng & compression settings)                    *"
	echo "*  14   Copy frameworks from ROM to apktool                               *"
	echo "*  15   Clean folders                                                     *"
	echo "*  16   Batch Operations Menu                                             *"
	echo "*                                                                         *"
	echo "*  0    Exit                                                              *"
	echo "***************************************************************************"
	printf "%s" "Please make your decision: "
	read ANSWER

	case "$ANSWER" in
		 1)   ap ;;
		 2)   ex ;;
		 3)  opt ;;
		 4)  zip ;;
		 5)   si ;;
		 6) zipa ;;
		 7)  apu ;;
		 8)   de ;;
		 9)   co ;;
		10)   si ;;
		11)  all ;;
		12) bopt ;;
		13)   tt ;;
		14)   fw ;;
		15)   cf ;;
		16)  batops ;;
                0) quit ;;
		 *)
			echo "Unknown command: '$ANSWER'"
		;;
	esac
}

batops () {
clear
	echo "**************************** ThemeR-Studio_V2 *****************************"
	echo "**************************** Batch Operations *****************************"
	echo "*  1    Decompile ROM                                                     *"
	echo "*  2    Compile apks                                                      *"
	echo "*  3    Zipalign apks                                                     *"
	echo "*                                                                         *"
	echo "*  0    Return to ThemeR-Studio Menu                                      *"
	echo "***************************************************************************"
	printf "%s" "Please make your decision: "
	read BATCHOPS

	case "$BATCHOPS" in
		1)      bde ;;
		2)      bco ;;
		3)      bza ;;
		0)  restart ;;
		*)
			echo "Unknown command: '$BATCHOPS'"
		;;
	esac
}


# Start
	mkdir -p $pam
	mkdir -p $bo
	mkdir -p $rom
	mkdir -p $ca
	mkdir -p $da
PATH="$PATH:$tools"
export PATH
# Test for needed programs and warn if missing
ERROR="0"
for PROGRAM in "optipng" "7za" "java" "sudo" "adb" "aapt"
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

while [ "1" = "1" ] ;
do
	restart
done
exit 0
