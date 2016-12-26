#!/bin/bash
# install.sh - installs configuration files

cmd="cp"
copy=1
dest_dir="$HOME"
force=0

while getopts "cd:efhl" opt; do
    case "$opt" in
        c)
            # Copy files to destination
            cmd="cp"
            copy=1
            ;;
        d)
            # Specify the destination directory
            dest_dir="$OPTARG"
            ;;
        e)
            set -e
            ;;
        f)
            # Force removal of existing files at the destination
            force=1
            ;;
        h)
            # List options
            echo "Usage: $(basename $0) [-d dest_dir] [-cefhl]"
            echo "Available options:

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
            cmd="ln -s"
            copy=0
            ;;
        *)
            echo "Unrecognized option: -$opt"
            exit 1
            ;;
    esac
done

# Use the force flag
if [ $force -eq 1 ]; then
    cmd="$cmd -f"
fi

# Install configuration files
for file in bashrc bash_aliases bash_functions bash_profile gitconfig hgrc \
            vimrc tmux.conf Xresources zshrc zsh_aliases zsh_functions
do
    $cmd -v "${PWD}/${file}" "${dest_dir}/.${file}"
done

# Install the vim directory. Ignores $force
if [ -e "${dest_dir}/.vim" ]; then
    echo "Skipping vim directory: ${dest_dir}/.vim exists"
else
    if [ $copy -eq 1 ]; then
        cp -r vim "${dest_dir}/.vim"
    else
        ln -s "${PWD}/vim" "${dest_dir}/.vim"
    fi
fi

# Install executable scripts
for file in $(find scripts -type f)
do
    $cmd -v "${PWD}/${file}" "/usr/local/bin/$(basename $file)"
done
