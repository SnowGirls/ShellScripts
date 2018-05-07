
# AppIconResizer.sh path_to_[1024x1024]_png_file

DATESTRING=$(date +%Y%m%d%H%M%S)
PNG_FILE_PATH=$1
OUTPUT_FILES_PATH=$(dirname ${PNG_FILE_PATH})/${DATESTRING}-Resize/
mkdir ${OUTPUT_FILES_PATH}

sizes=(1024 180 167 152 120 114 87 80 76 60 58 57 40 29 20 )

FN="${1##*/}"
FNNOEXT="${FN%.*}"
EXT="${FN##*.}"

#echo 'filename ' $FN ' filename no ext ' $FNNOEXT  ' ext ' $EXT

for size in "${sizes[@]}"
do
	NEWFILENAME=Icon-${size}.${EXT}
	#echo $NEWFILENAME
	sips -z $size $size $1  --out ${OUTPUT_FILES_PATH}/$NEWFILENAME
done


