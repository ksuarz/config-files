#!/bin/bash
# install.sh - installs configuration files

COMMAND="cp"
COPY=1
DEST_DIR="$HOME"
FORCE=0
OPTIND=1

while getopts "cd:efhl" opt; do
    case "$opt" in
        c)
            # Copy files to destination
            COMMAND="cp"
            COPY=1
            ;;
        d)
            # Specify the destination directory
            DEST_DIR="$OPTARG"
            ;;
        e)
            set -e
            ;;
        f)
            # Force removal of existing files at the destination
            FORCE=1
            ;;
        h)
            # List options
            echo "install.sh: installs configuration files
Usage: install.sh [-d DEST_DIR] [-cefhl]

Options:
    -c  Copy files to the destination (default). Overrides -l
    -d  Specify the destination directory. Default is \$HOME
    -e  Stop on error
    -f  Force the removal of existing files at the destination
    -h  Show this message and exit
    -l  Symbolically link files at the destination. Overrides -c"
            exit 0
            ;;
        l)
            # Create symlinks to files
            COMMAND="ln -s"
            COPY=0
            ;;
        *)
            echo "Unrecognized option: -$opt"
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

# Use the force flag
if [ $FORCE -eq 1 ]; then
    COMMAND="${COMMAND} -f"
fi

# Install the standard files
for FILE in bashrc bash_aliases bash_functions bash_profile gitconfig hgrc \
            vimrc tmux.conf Xresources zshrc zsh_aliases zsh_functions
do
    $COMMAND -v "${PWD}/${FILE}" "${DEST_DIR}/.${FILE}"
done

# Install the vim directory. Ignores $FORCE
if [ -e "${DEST_DIR}/.vim" ]; then
    echo "Skipping vim directory: ${DEST_DIR}/.vim exists"
else
    if [ $COPY -eq 1 ]; then
        cp -r vim "${DEST_DIR}/.vim"
    else
        ln -s "${PWD}/vim" "${DEST_DIR}/.vim"
    fi
fi
