#!/bin/bash

# Check if program exists
# $0 is the function name
# $1 is the first arg
# 2>/dev/null redirects output to stderr instead of stdout
# > redirect standard output (implicit 1>)
# & what comes next is a file descriptor, not a file (only for right hand side of >)
# 2 stderr file descriptor number
check_required_program () {
	hash $1 2>/dev/null || {
		echo $1 is required but not installed
		exit 1
	}
}

check_recommended_program () {
	hash $1 2>/dev/null || {
		echo $1 is recommended but not installed
	}
}

# Check if git is installed
check_required_program git

# General variables
base_dir=$(pwd) # no trailing slash

# Add function to ~/.bashrc to check for and display
# the git branch that you're currently in
bashrc_file=$HOME/.bashrc

#######################################################################
# THIS DOES NOT WORK YET DUE TO ALL OF THE SPECIAL CHARACTERS
#######################################################################

if [ -w $bashrc_file ] && [ ! grep -q DISPLAY_GIT_BRANCH $bashrc_file ]
then
	cat <<EndOfMessage >> $bashrc_file

	# [DISPLAY_GIT_BRANCH]
	function parse_git_branch () {
	  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
	}
	YELLOW="\[\033[0;33m\]"
	GREEN="\[\033[0;32m\]"
	NO_COLOR="\[\033[0m\]"
	PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "
	EndOfMessage
fi

exit 1