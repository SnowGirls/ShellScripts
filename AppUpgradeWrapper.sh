#!/bin/bash

# AppUpgradeWrapper.sh path/to/your_old.app path/to/your_new.app EXECUTBALE_FILE
#
# e.g.
# AppUpgradeWrapper.sh ./Girls.app ./MobileMail.app MobileMail


OLD_APP=$1
NEW_APP=$2
EXE_NAME=$3


echo -e "1... Upgrading App \n"
DST_APP="$(AppUpgrade.sh ${OLD_APP} ${NEW_APP} ${EXE_NAME} | grep "New app is:" | awk -F ':' '{print $2}')"


echo -e "2... Changing Display Name \n"
DISPLAY_NAME="$(plutil -p ${OLD_APP}/Info.plist | grep CFBundleDisplayName | awk -F '=>' '{print $2}' | sed 's/"//g')"
# DISPLAY_NAME="$(plutil -p ${OLD_APP}/zh_CN.lproj/InfoPlist.strings | grep CFBundleDisplayName | awk -F '=>' '{print $2}' | sed 's/"//g')"
AppDisplayName.sh ${DISPLAY_NAME} ${DST_APP}


echo -e "3... Done \n"

