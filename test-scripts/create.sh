#!/bin/bash
# create - Makes a new file from a template via command line.
# @author Kyle Suarez

# Set the default path.
DEFPATH="~/Templates"

function showhelp {
    echo create - Make a new file from a template via command line
    echo ""
    echo "Note: This does not accept any flags as of now."
    echo "usage: create (template) [name]"
    echo "  template: Any file to use as a template."
    echo "  name:If specified, create a new file named 'name'"
    echo "      with the given filetype."
}

function fromtemplate {
    echo Trying to create from template: $1
    if [ ! -f $1 ]
    then
        echo Looking in default path: $DEFPATH/$1
        # Try the default path
        if [ -f "$DEFPATH/$1" ]
        then
            ex="cp $DEFPATH/$1 ."
            eval ex
        else
            echo That file does not exist.
        fi
    else
        # Found it
       ex="cp $1 ."
       eval ex
    fi
}

if [ $# -eq 0 ]
then
    # No arguments given.
    showhelp
elif [ $# -eq 1 ]
then
    # Create from template
    echo Creating from template.
    fromtemplate $1
elif [ $# -eq 2 ]
then
    # Create and rename
    echo Too many arguments.
else
    echo Too many arguments.
    showhelp
fi

exit
