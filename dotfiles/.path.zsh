#!/bin/zsh
# paths.zsh - A well-organized location for $PATH additions

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"

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
    $PATH
)

# Use a ZSH array expression to join path components with ":"
export PATH=${(j.:.)path_components}

# Load autocompletes
fpath=($HOME/.zsh/completion $fpath)

# Deduplicate paths
typeset -U path
typeset -U fpath

# A useful alias for pretty-printing the path
alias prettypath='echo $PATH | tr -s ":" "\n" | sort | uniq'
alias prettyfpath='echo $FPATH | tr -s ":" "\n" | sort | uniq'