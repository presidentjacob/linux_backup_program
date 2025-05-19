#! /bin/bash

source backup_library.sh

set -euo pipefail

# backup_file="/mnt/backup/documents_backup_$(date +%Y-%m-%d_%H-%M-%S)"
backup_dir="/mnt/backup"
# check=${backup_dir%/}

# Check if backup files exist
files=$(shopt -s nullglob dotglob; echo "$backup_dir"/*)
if (( ${#files} )); then
	echo "One or more backup files exist as:"
	display_directories $backup_dir
	read -p "Would you like to delete any of these [y/n]: " input
	read_input $input $backup_dir
fi

# sudo rsync -avh --progress ~/Documents $backup_dir
