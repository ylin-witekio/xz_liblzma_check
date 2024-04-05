#!/usr/bin/env bash

# Creating and validating bin_dir
bin_dir=${1:-/usr/bin}
compromised=false

# Remove Trailing / chars
trim_bin_dir_str(){
	while [[ $bin_dir =~ /$ ]]
	do
		bin_dir=${bin_dir:0:-1}
	done
}

# Find the realpath of search dir
realpath_bin_dir_str(){
	if [[ ! -d $bin_dir ]]
	then
		echo "Invalid search dir..."
		return 1
	else
		if [[ -L $bin_dir ]]
		then
			bin_dir=$(realpath $bin_dir)
		fi
	fi
}

check_ldd_lzma_str(){
	lzma_so=$(realpath $3)
	if [[ ${lzma_so: -5} == "5.6.0" || ${lzma_so: -5} == "5.6.1" ]]
	then
		echo "Compromised libzma.so found!"
		compromised=true
	else
		return 1
	fi
}

check_bin(){
	full_bin_path="$bin_dir/$1"
	lzma_str=$(ldd $full_bin_path 2> /dev/null | grep liblzma)

	if [[ ! -z $lzma_str ]]
	then
		check_ldd_lzma_str $lzma_str && \
		echo "$full_bin_path contains compromised liblzma.so!"
	fi
}

search_dir(){
	echo "Searching for xz libs in: $bin_dir"
	bin_files=$(ls $bin_dir)
	#echo $bin_files

	for b in $bin_files
	do
		check_bin $b
	done

	if [[ $compromised == "true" ]]
	then
		echo "Compromised libs found on your machine!"
	else
		echo "This script has not found any compromised libs."
	fi
}

trim_bin_dir_str && \
realpath_bin_dir_str && \
search_dir
