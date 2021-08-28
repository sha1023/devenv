#!/bin/bash 
echo sourcing ${BASH_SOURCE[0]}
alias ebash="vim ${BASH_SOURCE[0]}; source ${BASH_SOURCE[0]}"

PS1="\[$(tput setaf 1)\]I would rather be a sunflower\[$(tput sgr0)\]:\[\e[0;33m\]\[\e[0;34m\]\W\[\e[0m\]\$"

