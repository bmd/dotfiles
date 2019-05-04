#!/bin/zsh
# paths.zsh - A well-organized location for $PATH additions

path_components=(
    /usr/local/bin
    /usr/local/sbin
    $HOME/golang/bin
    $HOME/.composer/vendor/bin
    $PATH
)

# Use a ZSH array expression to join path components with ":"
export PATH=${(j.:.)path_components}

# A useful alias for pretty-printing the path
alias prettypath='echo $PATH | tr -s ":" "\n" | sort | uniq'
