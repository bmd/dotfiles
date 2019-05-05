#!/bin/zsh
# .aliases.zsh

# Simple command aliases
alias bt='ssh bastion-tools'
alias mkdir="mkdir -p"
alias reload="source ~/.zshrc"

# Include my shell libraries
source $HOME/.aws.zsh
source $HOME/.helpers.zsh

# Utilities
clone() { cd ~/git && git clone git@github.com:$1 && cd $(basename "$1"); }
err() { echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2; }
j64() { echo $@ | base64 --decode | jq . ; }
mcd() { mkdir -p "$1" && cd "$1"; }
monitor_url() { curl::loop $@ ; }
yq() { yaml2json | jq $@ ; }

# SSH Keys helpers
backup_ssh_keys() { op::keys::backup $HOME/.ssh "Blue State Digital" "ssh-keys"; }
restore_ssh_keys() { op::keys::restore $HOME/.ssh "Blue State Digital" "ssh-keys" ; }

# Tesseract helpers
tesseract_cert() { aws::acm::lookup 093597997342 $1 us-east-1 bsd-tesseract | jq . ; }

# We need to bridge the way we identify environments in tesseract (e.g. "auth-int") with
# how our Beanstalk environments are named.
#
# Usage:
#   tesseract_session environment
# Example:
#   tesseract_session auth-int
tesseract_session() {
    local name parts beanstalk

    name="$1"
    parts=("${(@s/-/)name}")
    beanstalk=$(
        aws resourcegroupstaggingapi get-resources \
            --resource-type-filters elasticbeanstalk \
            --tag-filters Key=service,Values=${parts[1]} Key=environment,Values=${parts[2]} \
            | jq -r '.ResourceTagMappingList[0].Tags[] | select(.Key == "Name").Value'
    )

    aws::beanstalk::session::start ${beanstalk}
}
