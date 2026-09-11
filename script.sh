#!/bin/bash

# log
echo "$(date +'%F %T') | INFO | STASRT | app started successfully" >> activity.log

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
read -p 'Enter the destination directory name: ' folder

echo ''

if [ ! -d $folder ] ; then
	# log
	echo "$(date +'%F %T') | WARNING | DIRECTORY | $(pwd)/$folder directory not found" >> activity.log

	echo 'No such directory exists!'

	# log
	echo "$(date +'%F %T') | INFO | FINISH | app closed successfully" >> activity.log

	exit 1
fi

path="$(pwd)/$folder"

# log
echo "$(date +'%F %T') | INFO | DIRECTORY | destination directory is $path" >> activity.log

# make necessary directoies
directoies=('Images' 'Documents' 'Videos' 'Audios' 'Archives')

for dir in ${directoies[@]} ; do
	if [ ! -d "$path/$dir" ] ; then
		mkdir "$path/$dir"

		# log
		echo "$(date +'%F %T') | INFO | DIRECTORY | $path/$dir directory was created" >> activity.log
	else
		echo "$(date +'%F %T') | INFO | DIRECTORY | $path/$dir directory exists" >> activity.log
	fi
done

# declare an array to store file formats
declare -A formats

formats[Images]="jpeg jpg png gif webp svg bmp heic"
formats[Documents]="pdf docx txt"
formats[Videos]="mp4 mkv avi mov hevc"
formats[Audios]="mp3 wav flac m4a"
formats[Archives]="zip rar 7z tar"

# log
echo "$(date +'%F %T') | INFO | FORMAT | all the extensions have been identified" >> activity.log

# declare an array to count how many of each format moved
declare -A total

total[Images]=0
total[Documents]=0
total[Videos]=0
total[Audios]=0
total[Archives]=0

# move each file to their directories
for type in ${directoies[@]} ; do
	for format in ${formats[$type]} ; do
		if [ ! "$(find . -maxdepth 1 -type f -name "*.$format")" == '' ] ; then
			# log
			echo "$(date +'%F %T') | INFO | FORMAT | a file in $format format was found" >> activity.log

			for file in *".$format" ; do
				dest_name=$file

				while [ true ] ; do
					if [ ! -f "$path/$type/$dest_name" ] ; then
						mv -i $file "$path/$type/$dest_name"
						total[$type]=$((${total[$type]} + 1))

						# log
						echo "$(date +'%F %T') | INFO | MOVE | $(pwd)/$file -> $path/$type/$dest_name" >> activity.log
						break
					else
						# log
						echo "$(date +'%F %T') | WARNING | MOVE | $path/$type/$dest_name already exists" >> activity.log

						echo "There is a file named $file in the $type folder."
						read -p "Choose a different name and extention for the file: " dest_name
						echo ''
					fi
				done
			done
		else
			# log
			echo "$(date +'%F %T') | INFO | DIRECTORY | no file in $format format was found." >> activity.log
		fi
	done
done

# final report
echo -e '\nFile transfer results\n'

for type in ${directoies[@]} ; do
	echo "$type: ${total[$type]}"
done

# log
echo "$(date +'%F %T') | INFO | FINISH | app closed successfully" >> activity.log