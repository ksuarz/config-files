#!/bin/bash
# clean.sh - remove configuration files

ALWAYS=0
CONFIG_DIR="$HOME"
FLAGS=""
OPTIND=1

while getopts "ad:fhim" opt; do
    case "$opt" in
        a)
            # Always remove files, even if they don't match version control
            ALWAYS=1
            ;;
        d)
            # Specify the destination directory
            CONFIG_DIR="$OPTARG"
            ;;
        e)
            # Exit on error
            set -e
            ;;
        f)
            # Use the force flag with the remove command
            FLAGS="-f"
            ;;
        h)
            # List options
            echo "clean.sh: remove configuration files
Usage: remove.sh [-d CONFIG_DIR] [-aefhi]

Options:
    -a  Always remove files, even if they don't match version control
    -d  Specify the directory containing the config files. Default is \$HOME
    -e  Exit on error
    -f  No error for removing nonexistent files. Overrides -i
    -h  Show this message and exit
    -i  Interactively remove files. Overrides -f"
            exit 0
            ;;
        i)
            # Use interactive mode with the remove command
            FLAGS="-i"
            ;;
        *)
            echo "Unrecognized option: -$opt"
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

# Force flag or interactive mode
RM="rm $FLAGS"

# Remove the standard files
for FILE in bashrc bash_aliases bash_functions bash_profile gitconfig hgrc \
            vimrc tmux.conf Xresources zshrc zsh_aliases zsh_functions
do
    INSTALLED="${CONFIG_DIR}/.${FILE}"
    if [ $ALWAYS -eq 1 ] || diff -q $FILE $INSTALLED > /dev/null 2>&1; then
        $RM -v $INSTALLED
    else
        echo "Ignoring $INSTALLED: differs from version control"
    fi
done
