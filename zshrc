# zshrc: zsh configuration

# Sensitivity options
CASE_INSENSITIVE="true"
HYPHEN_INSENSITIVE="true"

setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt PROMPT_SUBST

# Disable terminal flow control
unsetopt FLOW_CONTROL
stty -ixon -ixoff > /dev/null

# Primary prompt
export PS1=$'\n%n@%m:%~ $(ps1_prompt) '
export RPS1="%F{green}"'$(venv_prompt)'"%F{red}"'$(git_prompt)'"%F{blue}%D{%T}%f"
export RPS1_SAVED="$RPS1"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Emacs-style readline
bindkey -e

# Terminal settings
export EDITOR="vim"
export LANG="en_US.utf-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export TERM="xterm-256color"
export SHELL="/bin/zsh"

# History settings
export HISTFILE=~/.zsh_history
export HISTSIZE=15000
export SAVEHIST=15000

# MongoDB Toolchain
if [ -d "/opt/mongodbtoolchain/v4/bin" ]; then
    export PATH="/opt/mongodbtoolchain/v4/bin:$PATH"
fi

# Ignore . and .. in glob patterns like ".*"
export GLOBIGNORE=.:..

# Completion
autoload -U compinit && compinit

# Edit command line
autoload -U edit-command-line && zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# zsh-specific settings
zstyle ':completion:*' menu select

# Alias definitions
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# User-defined functions
if [ -f ~/.zsh_functions ]; then
    source ~/.zsh_functions
fi

#" vim: filetype=zsh
