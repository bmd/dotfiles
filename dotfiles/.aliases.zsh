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
alias gpm="git push origin master"

# ----------------------------------------
# Libraries
# ----------------------------------------

source $HOME/.aws.zsh
source $HOME/.helpers.zsh
source $HOME/.1password.zsh
source $HOME/.jetbrains.zsh

# ----------------------------------------
# Utilities
# ----------------------------------------

sav2csv() {
    R --no-save --silent -e "library(foreign); write.csv(read.spss(file='$1'), file='$2')"
}

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
