#!/bin/bash

# AppInstallDylib.sh your.dylib your.app EXECUTBALE_FILE 
#
# e.g. 
# AppInstallDylib.sh ./Desktop/Girls.dylib ./Desktop/MobileMail.app MobileMail


# Requirements: 
# optool -> https://github.com/alexzielenski/optool


DYLIB_PATH=$1
APP_PATH=$2
EXE_NAME=$3


APP_DIR=`dirname ${APP_PATH}`
APP_NAME=$(basename "${APP_PATH}")

extension="${APP_NAME##*.}"
filename="${APP_NAME%.*}"
datestring=$(date +%Y%m%d%H%M%S)

NEW_APP_PATH="${APP_DIR}/${filename}-${datestring}.${extension}"

cp -R $APP_PATH $NEW_APP_PATH
#echo "cp -R $APP_PATH $NEW_APP_PATH"
echo -e '1... copy new app done \n'



cp $DYLIB_PATH $NEW_APP_PATH
#echo "cp $DYLIB_PATH $NEW_APP_PATH"
echo -e '2... copy dylib to new app done \n'


dylib_libsubstrate="libsubstrate.dylib"
Framework_CydiaSubstrate="CydiaSubstrate.framework"
CydiaSubstrate_In_Framework="CydiaSubstrate.framework/CydiaSubstrate"

if [ -e "${NEW_APP_PATH}/${Framework_CydiaSubstrate}" -o -e "${NEW_APP_PATH}/${dylib_libsubstrate}" ]; then
	echo -e '3... libsubstrate.dylib or CydiaSubstrate.framework already exists in new app \n'
else
	Cydia_Framework_Dylib_Path="${HOME}/Workspaces/Cydia"
	if [ -e "${Cydia_Framework_Dylib_Path}/${Framework_CydiaSubstrate}" ]; then
		cp -R ${Cydia_Framework_Dylib_Path}/${Framework_CydiaSubstrate} $NEW_APP_PATH
	elif [ -e "${Cydia_Framework_Dylib_Path}/${dylib_libsubstrate}" ]; then
		cp -R ${Cydia_Framework_Dylib_Path}/${dylib_libsubstrate} $NEW_APP_PATH
	fi
	echo -e '3... copy libsubstrate.dylib or CydiaSubstrate.framework to new app done \n'
fi


DYLIB_NAME=$(basename "${DYLIB_PATH}")
NEW_DYLIB_PATH="${NEW_APP_PATH}/${DYLIB_NAME}"
Cydia_Framework_OR_Dylib=''

## case 1. use CydiaSubstrate.framework
if [ -e "${NEW_APP_PATH}/${Framework_CydiaSubstrate}" ]; then
	Cydia_Framework_OR_Dylib=${CydiaSubstrate_In_Framework}
## case 2. use libsubstrate.dylib
elif [ -e "${NEW_APP_PATH}/${dylib_libsubstrate}" ]; then
	Cydia_Framework_OR_Dylib=${dylib_libsubstrate}
else
	echo -e "!!! Error. No CydiaSubstrate.framework or libsubstrate.dylib found in .app\n"
fi
install_name_tool -change /Library/Frameworks/${CydiaSubstrate_In_Framework} @loader_path/${Cydia_Framework_OR_Dylib} $NEW_DYLIB_PATH
echo -e "4... use ${Cydia_Framework_OR_Dylib} and change path done \n"



EXE_PATH="${NEW_APP_PATH}/${EXE_NAME}"
optool install -c load -p @executable_path/${DYLIB_NAME} -t ${EXE_PATH}
#echo "optool install -c load -p @executable_path/${DYLIB_NAME} -t ${EXE_PATH}"
echo -e '5... insert dylib to target done \n'


echo "otool -L $EXE_PATH | grep @"
otool -L $EXE_PATH | grep @
echo "otool -L $NEW_DYLIB_PATH | grep @"
otool -L $NEW_DYLIB_PATH | grep @


echo -e '6... all done, next package the .ipa \n'

