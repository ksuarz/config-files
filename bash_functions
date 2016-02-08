# bash_functions: user-defined functions for bash

# Moving around
up() {
    if [ $# -eq 0 ]; then
        cd ..
    elif [ $# -eq 1 ]; then
        # Figure out how many directories up we're moving
        DIRECTORY=""
        for ((i=0; i<$1; i++)); do
            DIRECTORY="../${DIRECTORY}"
        done

        # Execute the directory change
        if [ -n "$DIRECTORY" ]; then
            cd "$DIRECTORY"
        fi
    fi
}

# Grab the git branch
git_current_branch() {
    # List the branches, find the one starting with an asterisk, then strip out
    # the asterisk, the leading space and any parentheses
    branch=$(git branch 2> /dev/null | grep "^\*" | cut -c 3- | tr -d "()")
    if [ -z "$branch" ]; then
        echo ""
    else
        echo "[$branch]"
    fi
}

activate_magic() {
    if [ -d "$HOME/incantations" ]; then
        export PATH="$HOME/incantations:$PATH"
        echo "Magic spells available:"
        ls "$HOME/incantations"
    fi
}

goto() {
    if [ $# -gt 1 ]; then
        echo "$0: error: expected only one argument"
    elif [ $# -eq 1 ]; then
        case $1 in
            cfg|config)
                cd "$HOME/programming/config-files"
                ;;
            d|docs)
                cd "$HOME/programming/docs"
                ;;
            m|mongo)
                cd "$HOME/programming/mongo"
                ;;
            mmap|mmapv1)
                cd "$HOME/programming/mongo/src/mongo/db/storage/mmap_v1"
                ;;
            storage)
                cd "$HOME/programming/mongo/src/mongo/db/storage"
                ;;
            wt|wiredtiger|wiredTiger)
                cd "$HOME/programming/mongo/src/mongo/db/storage/wiredtiger"
                ;;
            *)
                echo "Unknown location."
                ;;
        esac
    fi
}

please() {
    # Get the last command run and strip the history number plus whitespace
    CMD=$(history -1 | awk '{$1=""; print $0}' | sed -e 's/^[ ]*//')
    echo "sudo $CMD"
    eval "sudo $CMD"
}

#" vim: filetype=sh
