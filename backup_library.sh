#! /bin/bash

function display_directories {
	check=$1/*
	counter=1
	
	for dir in $check/*; do
		echo "$counter: $dir"
 		((counter++))
	done
	return $?
}

function read_input {
	input=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	directories=$2
	while [[ $input != 'y' && $input != 'n' ]]; do
		read -p "That is not a valid input, please enter a valid input [y/n]:" input
		input=$(echo "$input" | tr '[:upper:]' '[:lower:]')
	done
	if [[ $input == 'y' ]]; then
		delete_file $directories
	fi	
	return $?
}

# Count the number of files
function count_files {
	directories=$1
	counter=0
	for dir in $directories/*; do
		((counter++))
	done
	echo $counter

# Delete files that the user requests
function delete_file {
	directory=$1
	read -p "Which file would you like to delete? [Enter in the number displayed before the file]: " file_num
	count=$directory
	
	# If the file number entered is too low or high, request again
	while [[ $file_num <= 0 && $file_num > $count ]]; do
		read -p "Please enter a valid file number: " file_num
	done

	
