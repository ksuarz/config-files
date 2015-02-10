# bash_profile: executed by bash for login shells

# If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return
fi

# Source the local bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

#" vim: filetype=sh
