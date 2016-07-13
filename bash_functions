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

magic() {
    if [ -d "$HOME/incantations" ]; then
        export PATH="$HOME/incantations:$PATH"
        echo "Magic spells available:"
        ls "$HOME/incantations"
    fi
}

goto() {
    workspace="$HOME/programming"
    mongo="$workspace/$mongo"

    if [ $# -gt 1 ]; then
        echo "$0: error: expected only one argument"
    elif [ $# -eq 1 ]; then
        case $1 in
            cfg|config)
                cd "$workspace/config-files" ;;
            d|docs)
                cd "$workspace/docs" ;;
            db)
                cd "$mongo/src/mongo/db" ;;
            enterprise)
                cd "$workspace/enterprise-modules" ;;
            js|jstests)
                cd "$mongo/jstests" ;;
            m|mongo)
                cd "$mongo" ;;
            mmap|mmapv1)
                cd "$mongo/src/mongo/db/storage/mmap_v1" ;;
            p|prog|programming)
                cd "$workspace" ;;
            src)
                cd "$mongo/src/mongo" ;;
            storage)
                cd "$mongo/src/mongo/db/storage" ;;
            wt|wiredtiger|wiredTiger)
                cd "$mongo/src/mongo/db/storage/wiredtiger" ;;
            *)
                echo "Undefined label." ;;
        esac
    fi
}

please() {
    # Get the last command run and strip the history number plus whitespace
    CMD=$(history -1 | awk '{$1=""; print $0}' | sed -e 's/^[ ]*//')
    echo "sudo $CMD"
    eval "sudo $CMD"
}

open() {
    if [ -x /usr/bin/xdg-open ]; then
        /usr/bin/xdg-open $1 > /dev/null 2>&1 &
    fi
}

#" vim: filetype=sh
