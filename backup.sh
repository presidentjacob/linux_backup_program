#! /bin/bash

source backup_library.sh

set -euo pipefail

backup_dir="/mnt/backup/documents_backup_$(date +%Y-%m-%d_%H-%M-%S)"
check=${backup_dir%/}

# Check if backup files exist
if [[ ! -d $check/* ]]; then
	echo "One or more backup files exist as:"
	display_directories $check
	read "Would you like to delete any of these [y/n]: " input
	read_input $input
fi

# sudo rsync -avh --progress ~/Documents $backup_dir
