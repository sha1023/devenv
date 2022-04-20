#!/bin/bash

echo sourcing ${BASH_SOURCE[0]}

PS1="\[$(tput setaf 1)\]I would rather be a sunflower\[$(tput sgr0)\]:\[\e[0;33m\]\[\e[0;34m\]\W\[\e[0m\]\$"

### increase history size:
HISTSIZE=100000
HISTFILESIZE=$HISTSIZE

NormalColor=$(tput sgr0)
AlertColor=$(tput rev)

PrefixRegexForFunctions="^\s*function\s\+"
PrefixRegexForAliases="^\s*alias\s\+"
PrefixRegexForComments="^\s*###"

function _error_echo() {
    (>&2 echo -e "$(tput rev)$@$(tput sgr0)")
}

### Edit BASH_aliases
function ebash() {
    local PrefixRegexForFunctions
    PrefixRegexForFunctions="^\s*function\s\+"
    local PrefixRegexForAliases
    PrefixRegexForAliases="^\s*alias\s\+"
    if [ -z $1 ]
    then
        vim ${BASH_SOURCE[0]}
    else
        local SearchTerm
        SearchTerm="${PrefixRegexForFunctions}$1\|${PrefixRegexForAliases}$1"
        local SearchResults
        SearchResults=
        if [ $(grep -c $SearchTerm ${BASH_SOURCE[0]}) -ne 0 ]
        then
            vim +/$SearchTerm ${BASH_SOURCE[0]}
        else
            _error_echo "No Results Found For $1"
        fi
    fi
    source ${BASH_SOURCE[0]}
}
complete -A function -A alias ebash

### Edit VIMRC
alias evimrc="vim ${HOME}/.vimrc"

### Git aliases
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias ga='git add -A'
alias gd='git diff --color'

### History binds
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'
