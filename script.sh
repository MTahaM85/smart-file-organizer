#!/bin/bash

# print title
echo ' _______________________________________________________________'
echo '|   ____  __  __    _    ____ _____     _____ ___ _     _____   |'
echo '|  / ___||  \/  |  / \  |  _ \_   _|   |  ___|_ _| |   | ____|  |'
echo '|  \___ \| |\/| | / _ \ | |_) || |     | |_   | || |   |  _|    |'
echo '|   ___) | |  | |/ ___ \|  _ < | |     |  _|  | || |___| |___   |'
echo '|  |____/|_|  |_/_/   \_\_| \_\|_|     |_|   |___|_____|_____|  |'
echo '|     ___  ____   ____    _    _   _ ___ ______ _____ ____      |'
echo '|    / _ \|  _ \ / ___|  / \  | \ | |_ _|___   | ____|  _ \     |'
echo '|   | | | | |_) | |  __ / _ \ |  \| || |   /  /|  _| | |_) |    |'
echo '|   | |_| |  _ <| |_| |/ ___ \| |\  || | /  /__| |___|  _ <     |'
echo '|    \___/|_| \_\\____/_/   \_\_| \_|___|______|_____|_| \_\    |'
echo '|_______________________________________________________________|'
echo ''

# specify folder
read -p 'Enter the folder name: ' folder

echo ''

if [ ! -d $folder ] ; then
	echo 'No such directory exists!'
	exit 1
fi

path="$(pwd)/$folder"

# make necessary directoies
directoies=('Images' 'Documents' 'Videos' 'Audios' 'Archives')

for dir in ${directoies[@]} ; do
	if [ ! -d "$path/$dir" ] ; then
		mkdir "$path/$dir"
	fi
done

# declare an array to store file formats
declare -A formats

formats[Images]="jpeg jpg png gif webp svg bmp heic"
formats[Documents]="pdf docx txt"
formats[Videos]="mp4 mkv avi mov hevc"
formats[Audios]="mp3 wav flac m4a"
formats[Archives]="zip rar 7z tar"

# move each file to their directories
for type in ${directoies[@]} ; do
	for format in ${formats[$type]} ; do
		if [ ! "$(find . -maxdepth 1 -type f -name "*.$format")" == '' ] ; then
			for file in *".$format" ; do
				dest_name=$file

				while [ true ] ; do
					if [ ! -f "$path/$type/$dest_name" ] ; then
						mv -i $file "$path/$type/$dest_name"
						break
					else
						echo "There is a file named $file in the $type folder."
						read -p "Choose a different name and extention for the file: " dest_name
						echo ''
					fi
				done
			done
		fi
	done
done