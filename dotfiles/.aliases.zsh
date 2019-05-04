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
tesseract_session() { aws::beanstalk::session $1 ; }
