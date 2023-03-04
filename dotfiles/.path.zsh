#!/bin/zsh
# paths.zsh - A well-organized location for $PATH additions

path_components=(
    /usr/local/bin
    /usr/local/sbin
    /usr/local/opt/mysql-client/bin
    /usr/local/opt/ruby/bin
    $HOME/golang/bin
    $HOME/.composer/vendor/bin
    $HOME/.local/bin
    $GOPATH/bin
    $GOROOT/bin
    ${KREW_ROOT:-$HOME/.krew}/bin
    $PATH
)

# Use a ZSH array expression to join path components with ":"
export PATH=${(j.:.)path_components}

# Deduplicate and clean up
typeset -U path

# A useful alias for pretty-printing the path
alias prettypath='echo $PATH | tr -s ":" "\n" | sort | uniq'
