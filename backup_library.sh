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
	while [[ $input != 'y' ]] && [[ $input != 'n' ]]; do
		read "That is not a valid input, please enter a valid input [y/n]:" input
		input=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	done
}
