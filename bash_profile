# bash_profile: executed by bash for login shells

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source the local bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
