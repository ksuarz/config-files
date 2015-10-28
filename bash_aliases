# bash_aliases: user-defined aliases and functions for bash

# Color support for ls and grep
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Listing directories
alias l.='ls -ld .*'
alias ll='ls -l'
alias la='ls -lA'
alias lh='ls -Aoh'
alias lt='ls -lAtr'

# Start Chromium
if [ -x /usr/bin/google-chrome ]; then
    alias chrome='google-chrome > /dev/null 2>&1 &'
    alias incognito='google-chrome --incognito > /dev/null 2>&1 &'
elif [ -x /usr/bin/chromium ]; then
    alias chrome='chromium > /dev/null 2>&1 &'
    alias incognito='chromium --incognito > /dev/null 2>&1 &'
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
