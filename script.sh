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

if [ ! -d $folder ] ; then
    echo 'No such directory exists!'
    exit 1
fi

path="$(pwd)/$folder"

# make necessary directoies

directoies=("Images" "Documents" "Videos" "Archives")

for dir in ${directoies[@]} ; do
	if [ ! -d "$path/$dir" ] ; then
		mkdir "$path/$dir"
	fi
done