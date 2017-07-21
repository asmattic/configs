#!/bin/bash


# Setup custom configurations in linux
#
# Date: 07/20/2017
# Created By: Matthew Oldfield

# General variables
base_dir=$(pwd)
home_dir=$HOME

# Create vim style directories (mkdir -p creates all dir levels)
vim_dir="$home_dir/.vim"
vim_colors_dir="$home_dir/.vim/colors"
vim_monokai_file="$base_dir/files/monokai.vim"

# Check if dirs exist, create if needed
if [ ! -d $vim_dir ]
then
	echo $vim_dir does not exist, create $vim_colors_dir
	mkdir -p $vim_colors_dir
elif [ ! -d $vim_colors_dir ]
then
	echo $vim_colors_dir does not exist, create it
	mkdir -p $vim_colors_dir
else
	echo $vim_dir and $vim_colors_dir exist
	echo copy $vim_monokai_file to $vim_colors_dir
fi

# Place monokai.vim in colors dir

cp $vim_monokai_file $vim_colors_dir

# Check if .vimrc file exists, then write to it or create
vimrc_file="$home_dir/.vimrc"
if [ -w $vimrc_file ]
then
	echo $vimrc_file exists, appending monokai settings
else
	echo $vimrc_file does not exist, create it
	touch $vimrc_file
fi

# Append monokai settings
echo Appending monokai settings
echo "syntax enable" | sudo tee -a $vimrc_file
echo "colorscheme monokai" | sudo tee -a $vimrc_file
echo "\"Spaces and tabs" | sudo tee -a $vimrc_file
echo "set tabstop=4	\" 4 space tab" | sudo tee -a $vimrc_file
echo "set expandtab	\" use spaces for tabs" | sudo tee -a $vimrc_file
echo "set softtabstop	\" 4 space tab" | sudo tee -a $vimrc_file
echo "\" UI" | sudo tee -a $vimrc_file
echo "set number	\" show line numbers" | sudo tee -a $vimrc_file
echo "set showcmd	\" show command in bottom bar" | sudo tee -a $vimrc_file
echo "set nocursorline	\" highlight current line" | sudo tee -a $vimrc_file
echo "set showmatch	\" highlight matching parenthesis" | sudo tee -a $vimrc_file

