#!/bin/bash


# create the icons using AppIconsResizer.sh
ICONS_PATH=$1

DATESTRING=$(date +%Y%m%d%H%M%S)


# Xcode
XCODE_ICONS_NEW_PATH=$(dirname ${ICONS_PATH})/${DATESTRING}-Xcode
mkdir $XCODE_ICONS_NEW_PATH


cp $ICONS_PATH/Icon-20.png $XCODE_ICONS_NEW_PATH/AppIcon20x20~ipad.png

cp $ICONS_PATH/Icon-29.png $XCODE_ICONS_NEW_PATH/AppIcon29x29~ipad.png

cp $ICONS_PATH/Icon-40.png $XCODE_ICONS_NEW_PATH/AppIcon20x20@2x.png
cp $ICONS_PATH/Icon-40.png $XCODE_ICONS_NEW_PATH/AppIcon20x20@2x~ipad.png
cp $ICONS_PATH/Icon-40.png $XCODE_ICONS_NEW_PATH/AppIcon40x40~ipad.png

cp $ICONS_PATH/Icon-58.png $XCODE_ICONS_NEW_PATH/AppIcon29x29@2x.png
cp $ICONS_PATH/Icon-58.png $XCODE_ICONS_NEW_PATH/AppIcon29x29@2x~ipad.png

cp $ICONS_PATH/Icon-60.png $XCODE_ICONS_NEW_PATH/AppIcon20x20@3x.png

cp $ICONS_PATH/Icon-76.png $XCODE_ICONS_NEW_PATH/AppIcon76x76~ipad.png

cp $ICONS_PATH/Icon-80.png $XCODE_ICONS_NEW_PATH/AppIcon40x40@2x.png
cp $ICONS_PATH/Icon-80.png $XCODE_ICONS_NEW_PATH/AppIcon40x40@2x~ipad.png

cp $ICONS_PATH/Icon-87.png $XCODE_ICONS_NEW_PATH/AppIcon29x29@3x.png

cp $ICONS_PATH/Icon-120.png $XCODE_ICONS_NEW_PATH/AppIcon40x40@3x.png
cp $ICONS_PATH/Icon-120.png $XCODE_ICONS_NEW_PATH/AppIcon60x60@2x.png

cp $ICONS_PATH/Icon-180.png $XCODE_ICONS_NEW_PATH/AppIcon60x60@3x.png

cp $ICONS_PATH/Icon-152.png $XCODE_ICONS_NEW_PATH/AppIcon76x76@2x~ipad.png

cp $ICONS_PATH/Icon-167.png $XCODE_ICONS_NEW_PATH/AppIcon83.5x83.5@2x~ipad.png

# extra
cp $ICONS_PATH/Icon-180.png $XCODE_ICONS_NEW_PATH/AppIcon.png
cp $ICONS_PATH/Icon-180.png $XCODE_ICONS_NEW_PATH/AppIcon@3x.png

echo -e "Done. New files generated in ${XCODE_ICONS_NEW_PATH} \n"


# Penuins
Penuins_ICONS_NEW_PATH=$(dirname ${ICONS_PATH})/${DATESTRING}-Penuins
mkdir $Penuins_ICONS_NEW_PATH


cp $ICONS_PATH/Icon-29.png $Penuins_ICONS_NEW_PATH/AppIcon-129x29~ipad.png

cp $ICONS_PATH/Icon-58.png $Penuins_ICONS_NEW_PATH/AppIcon-129x29@2x.png
cp $ICONS_PATH/Icon-58.png $Penuins_ICONS_NEW_PATH/AppIcon-129x29@2x~ipad.png

cp $ICONS_PATH/Icon-40.png $Penuins_ICONS_NEW_PATH/AppIcon-140x40~ipad.png

cp $ICONS_PATH/Icon-76.png $Penuins_ICONS_NEW_PATH/AppIcon-176x76~ipad.png

cp $ICONS_PATH/Icon-80.png $Penuins_ICONS_NEW_PATH/AppIcon-140x40@2x.png
cp $ICONS_PATH/Icon-80.png $Penuins_ICONS_NEW_PATH/AppIcon-140x40@2x~ipad.png

cp $ICONS_PATH/Icon-87.png $Penuins_ICONS_NEW_PATH/AppIcon-129x29@3x.png

cp $ICONS_PATH/Icon-120.png $Penuins_ICONS_NEW_PATH/AppIcon-140x40@3x.png
cp $ICONS_PATH/Icon-120.png $Penuins_ICONS_NEW_PATH/AppIcon-160x60@2x.png

cp $ICONS_PATH/Icon-152.png $Penuins_ICONS_NEW_PATH/AppIcon-176x76@2x~ipad.png

cp $ICONS_PATH/Icon-180.png $Penuins_ICONS_NEW_PATH/AppIcon-160x60@3x.png

echo -e "Done. New files generated in ${Penuins_ICONS_NEW_PATH} \n"
