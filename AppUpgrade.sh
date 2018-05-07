#!/bin/bash

# AppUpgrade.sh path/to/your_old.app path/to/your_new.app EXECUTBALE_FILE
#
# e.g.
# AppUpgrade.sh ./MobileMail_v1.2.app ./MobileMail.app MobileMail


# Requirements: 
# optool -> https://github.com/alexzielenski/optool


OLD_APP=$1
NEW_APP=$2
MACHO_NAME=$3

APP_NAME=$(basename "${NEW_APP}")
DST_DIR=$(dirname ${NEW_APP}) 


## copy the new app
FILENAME="${APP_NAME%.*}"
EXTENSION="${NEW_APP##*.}"
DATESTRING=$(date +%Y%m%d%H%M%S)

DST_APP="${DST_DIR}/${FILENAME}-${DATESTRING}.${EXTENSION}"

cp -R $NEW_APP $DST_APP
echo -e '1... copy new app done \n'


## copy the dylibs
echo -e '2... copying dylibs \n'
COPIED_DYLIBS=''
function CopyDylibs() {
	local count=$#
	local i=1
	while [ $i -le $count ]; do
		eval "value=\${$i}"
		echo "Parameter $i is $value"
		macho_file=$value

		echo "$COPIED_DYLIBS" | grep -q "$macho_file"
		if [ $? -eq 0 ]; then
			echo "Dealing with recursive situations: $macho_file"
		else
			macho_path="${OLD_APP}/${macho_file}"
			cp ${macho_path} ${DST_APP}
			COPIED_DYLIBS="${COPIED_DYLIBS} ${macho_file}"
			# COPIED_DYLIBS=`echo ${COPIED_DYLIBS} | awk '{for (i=1;i<=NF;i++) if (!a[$i]++) printf("%s%s",$i,FS)}{printf("\n")}'`
			# COPIED_DYLIBS=$(echo ${COPIED_DYLIBS} | xargs -n1 | sort -u | xargs)
			echo "Copied dylibs: $COPIED_DYLIBS"

			dylibs="$(otool -L ${macho_path} | grep -E "@executable_path|@loader_path" | sort -u | awk -F '[/ ]' '{print $2}' | xargs)"
			echo "Got new dylibs: $dylibs"


			if [ -n "${dylibs}" ]; then
				CopyDylibs $dylibs
			fi
		fi	

		i=$((i+1))
	done
}

CopyDylibs ${MACHO_NAME}
echo -e "All copied dylibs: $COPIED_DYLIBS \n"

## insert the dylibs
echo -e '3... inserting dylibs \n'
OLD_EXE="${OLD_APP}/${MACHO_NAME}"
DST_EXE="${DST_APP}/${MACHO_NAME}"
EXE_DYLIBS=$(otool -L ${OLD_EXE} | grep -E "@executable_path|@loader_path" | awk '{print $1}')
INSERTED_DYLIBS=''

function InsertDylibs() {
	local count=$#
	local i=1
	while [ $i -le $count ]; do
		eval "value=\${$i}"
		echo "Parameter $i is $value"
		macho_path=$value

		echo "$INSERTED_DYLIBS" | grep -q "$macho_path"
		if [ $? -eq 0 ]; then
			echo "Dealing with already inserted situations: $macho_path"
		else
			optool install -c load -p ${macho_path} -t ${DST_EXE}
			INSERTED_DYLIBS="${INSERTED_DYLIBS} ${macho_path}"
			echo "Inserted dylibs: ${INSERTED_DYLIBS}"
		fi
		i=$((i+1))
	done
}

InsertDylibs ${EXE_DYLIBS}
echo -e "All inserted dylibs: $INSERTED_DYLIBS \n"

## copy the diff resources
echo -e '4... copying resources \n'
OLD_APP_NAME="$(basename $OLD_APP)"
DIFF_RESOURCES="$(diff -rq ${OLD_APP} ${DST_APP} | grep -E "Only in.*?${OLD_APP_NAME}" | sed 's/Only in //' | sed 's/: /\//')"
echo -e "Different resources: \n$DIFF_RESOURCES"
echo ${DIFF_RESOURCES} | xargs -J % cp -Rp % ${DST_APP}
echo -e "\n"


## copy the AppIcons
echo -e '5... copying AppIcons \n'
cp ${OLD_APP}/AppIcon*.png ${DST_APP}


echo -e '6... upgrade app done \n'
echo -e "New app is: ${DST_APP} \n"


