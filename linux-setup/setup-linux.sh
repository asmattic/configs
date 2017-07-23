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
if [[ ! -d $vim_dir ]]
then
    echo $vim_dir does not exist, create $vim_colors_dir
    mkdir -p $vim_colors_dir
elif [[ ! -d $vim_colors_dir ]]
then
    echo "${vim_colors_dir} does not exist, create it"
    mkdir -p $vim_colors_dir
else
    echo $vim_dir and $vim_colors_dir exist
    if [[ -f $vim_monokai_file ]]
    then
        echo "${vim_monokai_file} exists, (skip)"
    else
        echo copy $vim_monokai_file to $vim_colors_dir
        cp $vim_monokai_file $vim_colors_dir
    fi
fi

# Check if .vimrc file exists, then write to it or create
vimrc_file="${home_dir}/.vimrc"
if [[ -w "${vimrc_file}" ]]
then
    echo "${vimrc_file} exists"
else
    echo "${vimrc_file} does not exist, create it"
    touch $vimrc_file
fi

# Check if setting already there, add if not
#
# @param $1 {string} vim setting to insert if not already there
# @param $2 {file} file to check string in
add_vim_setting () {
    if grep -q "${1}" "${2}"
    then
        echo "${1} exists in ${2} (skip)"
    else
        echo "${1} does not exist in ${2} (append)"
        echo -e $1 | sudo tee -a $2
    fi
}

# Append monokai settings
echo "Appending ${vimrc_file} settings"

vim_settings=(
    "syntax enable"
    "colorscheme monokai"
    "\"Spaces and tabs"
)

for i in "${vim_settings[@]}"
do
    add_vim_setting "${i}" $vimrc_file
done
# add_vim_setting "syntax enable" $vimrc_file
# add_vim_setting "colorscheme monokai" $vimrc_file
# add_vim_setting "\"Spaces and tabs" $vimrc_file
add_vim_setting "set tabstop=4 \" 4 space tab" $vimrc_file
add_vim_setting "set expandtab \" use spaces for tabs" $vimrc_file
add_vim_setting "set softtabstop" $vimrc_file
add_vim_setting "\" UI" $vimrc_file
add_vim_setting "set number \" show line numbers" $vimrc_file
add_vim_setting "set showcmd \" show command in bottom bar" $vimrc_file
add_vim_setting "set nocursorline \" highlight current line" $vimrc_file
add_vim_setting "set showmatch \" hilight matching parenthesis" $vimrc_file

