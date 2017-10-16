# zshrc: zsh configuration

# Sensitivity options
CASE_INSENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# Primary prompt
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt PROMPT_SUBST
export PS1=$'\n'"%n@%m:%~ %F{green}$%f "
export RPS1="%F{green}"'$(venv_prompt)'"%F{red}"'$(git_prompt)'"%F{blue}%D{%T}%f"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Emacs-style readline
bindkey -e

# Terminal settings
export EDITOR="vim"
export LANG="en_US.utf-8"
export TERM="xterm-256color"
export SHELL="/bin/zsh"

# History settings
export HISTFILE=~/.zsh_history
export HISTSIZE=2000
export SAVEHIST=15000

# Ninja environment settings
if which ninja > /dev/null 2>&1 && which icecc > /dev/null 2>&1; then
    export NUM_CORES=400
fi

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
