#!/bin/zsh
# paths.zsh - A well-organized location for $PATH additions

path_components=(
    /usr/local/bin
    /usr/local/sbin
    /usr/local/opt/mysql-client/bin
    /usr/local/opt/ruby/bin
    /usr/local/opt/terraform@0.11/bin
    /usr/local/opt/helm@2/bin
    /usr/local/opt/awscli@1/bin
    $(gcloud info --format='value(installation.sdk_root)')/bin
    $HOME/golang/bin
    $HOME/.composer/vendor/bin
    $GOPATH/bin
    $GOROOT/bin
    ${KREW_ROOT:-$HOME/.krew}/bin
    $PATH
)

# Use a ZSH array expression to join path components with ":"
export PATH=${(j.:.)path_components}

# A useful alias for pretty-printing the path
alias prettypath='echo $PATH | tr -s ":" "\n" | sort | uniq'
