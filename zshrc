# zshrc: zsh configuration

# Sensitivity options
CASE_INSENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# Primary prompt
setopt PROMPT_SUBST
export PS1=$'\n'"%F{blue}[%D{%T}]%f%F{red}"'$(git_current_branch)'"%f %n@%m:%~"$'\n'"%F{green}$%f "

# Terminal settings
export EDITOR="vim"
export LANG="en_US.utf-8"
export TERM="xterm-256color"

# Ignore . and .. in glob patterns like ".*"
export GLOBIGNORE=.:..

# Completion
autoload -U compinit && compinit

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

#" vim: filetype=sh
