# zshrc: zsh configuration

# Sensitivity options
CASE_INSENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# Primary prompt
setopt PROMPT_SUBST
export PS1=$'\n'"%n@%m:%~ %F{green}$%f "
export RPS1="%F{red}"'$(git_current_status)'"%F{blue}%D{%T}%f"

# Emacs-style readline
bindkey -e

# Terminal settings
export EDITOR="vim"
export LANG="en_US.utf-8"
export TERM="xterm-256color"

# History settings
export HISTFILE="~/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=15000

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

#" vim: filetype=zsh
