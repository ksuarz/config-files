#!/bin/bash
# Shows how installed files differ from those in source control. Exit status is the number of
# differing files.
set -e

# Count how many files are different.
dirty=0

# Show differences only for files listed as arguments.
files=$@

# If no files were specified, show diffs for all of them.
if [ $# -eq 0 ]; then
    files="bashrc bash_aliases bash_functions bash_profile gitconfig hgrc vimrc
        tmux.conf Xresources zshrc zsh_aliases zsh_functions"
fi

for file in $files
do
    dirty=$((dirty+1))
    if ! diff -q "$file" "$HOME/.$file" > /dev/null 2>&1; then
        diff -u "$file" "$HOME/.$file" | pygmentize -l udiff
        echo ""
    fi
done

exit $dirty
