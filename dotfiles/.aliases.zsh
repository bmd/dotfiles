#!/bin/zsh
# .aliases.zsh

# ----------------------------------------
# Commands
# ----------------------------------------

alias jp='jupyter notebook'
alias mkdir="mkdir -p"
alias reload="source ~/.zshrc"
alias vsco="code ."
alias v="source ./venv/bin/activate"

# ----------------------------------------
# Libraries
# ----------------------------------------

source $HOME/.aws.zsh
source $HOME/.gcloud.zsh
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
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [ERROR] $@" >&2
}

# Pretty-print a base64-encoded JSON object.
#
# Usage:
#   j64 data
j64() {
     base64 --decode | jq $@
#    echo $@ | base64 --decode | jq .
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
