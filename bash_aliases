# bash_aliases: user-defined aliases and functions for bash

# Color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    eval $(dircolors -b)

    alias ls='ls --color=auto --group-directories-first'
    alias lll='ls -la --color=always | less -r'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='ls -G'
fi

# Listing directories
alias l.='ls -ld .*'
alias ll='ls -l'
alias la='ls -lA'
alias lh='ls -Aoh'
alias lt='ls -lAtr'

# Connecting to places
alias fly='ssh -X kds124@flyweight.cs.rutgers.edu'
alias eden='ssh kds124@eden.rutgers.edu'

# Start Chromium
if [ -x /usr/bin/google-chrome ]; then
    alias chrome='google-chrome > /dev/null 2>&1 &'
    alias incognito='google-chrome --incognito > /dev/null 2>&1 &'
elif [ -x /usr/bin/chromium ]; then
    alias chrome='chromium > /dev/null 2>&1 &'
    alias incognito='chromium --incognito > /dev/null 2>&1 &'
fi

# Set the desktop background
if [ -x /usr/bin/feh ] && [ -d ~/Pictures ]; then
    alias setbg='feh --bg-fill --no-fehbg'
    alias randombg='setbg ~/Pictures/$(ls ~/Pictures | sort -R | tail -n1)'
fi

# TeX options
if [ -x /usr/bin/pdflatex ] || [ -x /usr/texbin/pdflatex ]; then
    # Only consider .tex files with pdflatex
    complete -f -o dirnames -X "!*.tex" pdflatex
fi

# Read PDF files only
if [ -x /usr/bin/evince ]; then
    view() {
        if [ $# -gt 0 ]; then
            evince $@ > /dev/null 2>&1 &
        fi
    }
    complete -f -o dirnames -X "!*.pdf" view
else
    view() {
        if [ $# -gt 0 ]; then
            open $@
        fi
    }
    complete -f -o dirnames -X "!*.pdf" view
fi

#" vim: filetype=sh
