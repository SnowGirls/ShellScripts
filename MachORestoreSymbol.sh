#!/bin/bash

# MachORestoreSymbol.sh path/to/EXECUTABLE_FILE
# 
# e.g.
# MachORestoreSymbol.sh ~/Desktop/MobileMail


# Requirements: 
# restore-symbol -> https://github.com/tobefuturer/restore-symbol


MachO_Path=$1

MachO_Dir=$(dirname $MachO_Path)
MachO_Name=$(basename $MachO_Path)
MachO_Description=$(file $MachO_Path)

echo -e "1. Mach-O description: ${MachO_Description}. \n"

MachO_symbol=${MachO_Path}_symbol

if [[ $MachO_Description =~ "armv7" && $MachO_Description =~ "arm64" ]] 
then

	if [[ $MachO_Description =~ "armv7" ]]
	then
		MachO_armv7=${MachO_Path}_armv7
		MachO_armv7_symbol=${MachO_armv7}_symbol

		lipo -thin armv7 $MachO_Path -output $MachO_armv7 
		restore-symbol $MachO_armv7 -o $MachO_armv7_symbol
	fi

	if [[ $MachO_Description =~ "arm64" ]]
	then
		MachO_arm64=${MachO_Path}_arm64
		MachO_arm64_symbol=${MachO_arm64}_symbol

		lipo -thin arm64 $MachO_Path -output $MachO_arm64 
		restore-symbol $MachO_arm64 -o $MachO_arm64_symbol
	fi


	if [[ $MachO_armv7_symbol && $MachO_arm64_symbol ]]
	then
		lipo -create $MachO_armv7_symbol $MachO_arm64_symbol -output $MachO_symbol


		rm $MachO_armv7
		rm $MachO_arm64
		rm $MachO_armv7_symbol
		rm $MachO_arm64_symbol
	fi

else

	restore-symbol $MachO_Path -o $MachO_symbol

fi

MachO_backup=${MachO_Dir}/../${MachO_Name}_backup

mv $MachO_Path $MachO_backup
echo -e "\n2. Original Mach-O file move to ${MachO_backup}."

mv $MachO_symbol $MachO_Path
echo -e "\n3. Restore symbols done.\n" 



