#!/bin/bash

# AppDisplayName.sh NEW_NAME path/to/your.app
#
# e.g.
# AppDisplayName.sh Your_Name ./Desktop/MobileMail.app


plutil -replace CFBundleDisplayName -string $1 $2/Info.plist
plutil -replace CFBundleDisplayName -string $1 $2/zh_CN.lproj/InfoPlist.strings

plutil -p $2/Info.plist | grep "CFBundleDisplayName"
plutil -p $2/zh_CN.lproj/InfoPlist.strings | grep "CFBundleDisplayName"

