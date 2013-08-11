# bash_aliases: user-defined aliases for bash

# Listing directories
alias ll='ls -l'
alias la='ls -lA'
alias lh='ls -Aoh'
alias lt='ls -Alrt'
alias l.='ls -ld .*'
alias lll='ls -la | less'

# Moving around
alias ..='cd ..; ls -l'
alias home='cd; ls -l'

# Start up programs with a GUI in the background
alias gvim-start='gvim > /dev/null 2>&1 &'
alias chrome='google-chrome > /dev/null 2>&1 &'
alias chrome-incognito='google-chrome --incognito > /dev/null 2>&1 &'

# For hard-to-remember commands
alias ports=netstat
alias cpuinfo=lscpu
alias show-options=shopt
