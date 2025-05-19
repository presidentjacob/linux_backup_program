#! /bin/bash

function display_directories {
	local check=$1
	local counter=1
	
	for dir in $check/*; do
		echo "$counter: $dir"
 		((counter++))
	done
	return $?
}

# Count the number of files
function count_files {
	local directories=$1
	local counter=0
	for dir in $directories/*; do
		((counter++))
	done
	echo $counter
}

# Delete files that the user requests
function delete_file {
	local directory=$1
	local files=()
	local input='y'
	while [[ $input == 'y' ]]; do
		read -p "Which file would you like to delete? 
		[Enter in the number displayed before the file]: " file_num
		count=$(count_files $directory)
	
		# If the file number entered is too low or high, request again
		while (( $file_num <= 0 && $file_num > $count )); do
			read -p "Please enter a valid file number: " file_num
		done

		# Delete the file
		for file in "$directory"/*; do
			files+=("$file")
		done

		# Delete the file and unset the index in the array
		file_num=$((file_num - 1))
		sudo rm -rf ${files[file_num]}
		unset 'files[file_num]'

		# Rebuild array
		files=("${files[@]}")
		
		display_directories $directory

		# Ask if the user wants to delete more files
		while true; do

			read -p "Would you like to delete another file? [y/n]: " input

			input=$(echo "$input" | tr '[:upper:]' '[:lower:]')
			[[ $input != 'y' && $input != 'n' ]] || break
		done
	done
	return $?
}

function read_input {
	local input=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	local directories=$2
	while [[ $input != 'y' && $input != 'n' ]]; do
		read -p "That is not a valid input, please enter a valid input [y/n]:" input
		input=$(echo "$input" | tr '[:upper:]' '[:lower:]')
	done

	# Check if the user wants to delete files
	if [[ $input == 'y' ]]; then
		delete_file $directories
	fi	
	return $?
}
