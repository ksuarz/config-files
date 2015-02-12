# bash_functions: user-defined functions for bash

# Moving around
up() {
    if [ $# -eq 0 ]; then
        cd ..
    elif [ $# -eq 1 ]; then
        for ((i=0; i<$1; i++)); do
            cd ..
        done
    fi
}

# Handy opener for files
if [ -x /usr/bin/xdg-open ]; then
    open() {
        if [ $# -gt 0 ]; then
            xdg-open $1 > /dev/null 2>&1 &
        fi
    }
elif [ -x /usr/bin/gvfs-open ]; then
    open() {
        if [ $# -gt 0 ]; then
            gvfs-open $1 > /dev/null 2>&1 &
        fi
    }
fi

# Get information from NextBus
rubus () {
    stop="$1$2$3"

    if [ -z "$stop" ]; then
        stop="hill"
    fi

    curl "http://vverma.net/nextbus/nextbus.php?android=1&s=$stop"
}

# Grab the git branch
git_current_branch() {
    # List the branches, find the one starting with an asterisk, then strip out
    # both the asterisk and whitespace
    branch=$(git branch 2> /dev/null | grep "^\*" | tr -d " *")
    if [ -z $branch ]; then
        echo ""
    else
        echo "on $branch "
    fi
}

#" vim: filetype=sh