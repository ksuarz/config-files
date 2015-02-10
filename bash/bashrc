# bashrc: executed by bash for non-login shells

# If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return
fi

# Use a custom primary prompt
export PS1='\n[ \u@\h in \w $(git_current_branch)]\n\$ '

# History settings
export HISTCONTROL=ignoreboth
export HISTFILESIZE=20000
export HISTSIZE=10000

# Terminal settings
export TERM='xterm-256color'

# Ignore . and .. in glob patterns like ".*"
export GLOBIGNORE=.:..

# Other shell options
shopt -s cdspell            # Automatically correct directory name typos
shopt -s checkwinsize       # Check the size of the window after each command
shopt -s cmdhist            # Save all lines of multiple-line command together
shopt -s dotglob            # Expansion includes files starting with .
shopt -s extglob            # Use extended pattern matching
shopt -s histappend         # Append to history instead of overwriting it
shopt -s hostcomplete       # Attempt hostname completion
shopt -s nocaseglob         # Use case-insensitive globbing

# Source our alias definitions
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# User-defined functions
if [ -f ~/.bash_functions ]; then
    source ~/.bash_functions
fi

# Standard bash autocompletion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi
