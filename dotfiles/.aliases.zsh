#!/bin/zsh
# .aliases.zsh

# ----------------------------------------
# Commands
# ----------------------------------------

alias bt='ssh bastion-tools'
alias mkdir="mkdir -p"
alias reload="source ~/.zshrc"

# ----------------------------------------
# Libraries
# ----------------------------------------

source $HOME/.aws.zsh
source $HOME/.helpers.zsh

# ----------------------------------------
# Utilities
# ----------------------------------------

# Clone a github repository and then go into the directory created.
#
# Usage:
#   clone repository
# Example:
#   clone bmd/dotfiles
clone() {
    cd ~/git && git clone git@github.com:$1 && cd $(basename "$1")
}

# Print a timestamp and message to stdout
#
# Usage:
#   err message
# Example:
#   err "Your function call is bad and you should feel bad"
err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

# Pretty-print a base64-encoded JSON object.
#
# Usage:
#   j64 data
j64() {
    echo $@ | base64 --decode | jq .
}

# Use JQ with YAML data by converting the YAML to JSON on the fly.
# NB: this will probably perform horribly with large objects, it's just
# meant as a convenience method, not for heavy lifting. You can also
# pass through most JQ options here, although it hasn't been exhaustively
# tested.
#
# Usage:
#   yq data [...options]
yq() {
    yaml2json | jq $@
}

# Create a new directory and change into it
#
# Usage:
#   mcd foo/bar/baz
mcd() {
    mkdir -p "$1" && cd "$1"
}

# Monitor a URL at a defined interval and print out a templated string.
# The format string is passed to `curl -w`.
#
# Usage:
#   monitor_url url interval fmt
# Examples:
#   monitor_url https://google.com
#   monitor_url https://google.com 5 "The status code is: %{http_code}"
monitor_url() {
    curl::loop $@
}

# Sign in to 1Password CLI and set the resulting session token as an
# environment variable.
#
# Usage
#   ops
ops() {
    eval $(op signin my)
}

# Backup my SSH keys to a 1Password vault using the op CLI tool. You
# need to run `ops` to log in to your 1Password account locally before
# this will work.
#
# Usage:
#   backup_ssh_keys
backup_ssh_keys() {
    op::keys::backup $HOME/.ssh "Blue State Digital" "ssh-keys"
}

# Restore my backed-up SSH keys from a 1Password vault You
# need to run `ops` to log in to your 1Password account locally before
# this will work.
#
# Usage:
#   restore_ssh_keys
restore_ssh_keys() {
    op::keys::restore $HOME/.ssh "Blue State Digital" "ssh-keys"
}

# Look up an individual ACM certificate by ID in Tesseract and pretty-print
# the result with jq.
#
# Usage:
#   tesseract_cert id
tesseract_cert() {
    aws::acm::lookup 093597997342 $1 us-east-1 bsd-tesseract | jq .
}

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
