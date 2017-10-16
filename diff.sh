#!/bin/bash
# Shows how installed files differ from those in source control.
set -e

# Show differences only for files listed as arguments.
files=$@

# If no files were specified, show diffs for all of them.
if [ $# -eq 0 ]; then
    files="bashrc bash_aliases bash_functions bash_profile gitconfig hgrc vimrc
        tmux.conf Xresources zshrc zsh_aliases zsh_functions"
fi

for file in $files
do
    if ! diff -q "$file" "$HOME/.$file" > /dev/null 2>&1; then
        diff -u "$file" "$HOME/.$file" | pygmentize -l udiff
    fi
done
