#!/bin/bash
# clean.sh - remove configuration files

always=0
config_dir="$HOME"
flags=""

while getopts "ad:fhim" opt; do
    case "$opt" in
        a)
            # Always remove files, even if they don't match version control
            always=1
            ;;
        d)
            # Specify the destination directory
            config_dir="$OPTARG"
            ;;
        e)
            # Exit on error
            set -e
            ;;
        f)
            # Use the force flag with the remove command
            flags="-f"
            ;;
        h)
            # List options
            echo "Usage: $(basename $0) [-d config_dir] [-aefhi]"
            echo "Available options:

    -a  Always remove files, even if they don't match version control
    -d  Specify the directory containing the config files. Default is \$HOME
    -e  Stop on error
    -f  No error for removing nonexistent files. Overrides -i
    -h  Show this message and exit
    -i  Interactively remove files. Overrides -f"
            exit 0
            ;;
        i)
            # Use interactive mode with the remove command
            flags="-i"
            ;;
        *)
            echo "Unrecognized option: -$opt"
            exit 1
            ;;
    esac
done

# Force flag or interactive mode
remove="rm $flags"

# Remove configuration files
for file in bashrc bash_aliases bash_functions bash_profile gitconfig hgrc \
            vimrc tmux.conf Xresources zshrc zsh_aliases zsh_functions
do
    installed="${config_dir}/.${file}"
    if [ $always -eq 1 ] || diff -q $file $installed > /dev/null 2>&1; then
        $remove -v $installed
    else
        echo "Ignoring $installed: differs from version control"
    fi
done

# Remove executables
for file in $(find scripts -type f)
    installed="/usr/local/bin/$(basename $file)"
    if [ $always -eq 1 ] || diff -q $file $installed > /dev/null 2>&1; then
        $remove -v $installed
    else
        echo "Ignoring $installed: differs from version control"
    fi
do
done
