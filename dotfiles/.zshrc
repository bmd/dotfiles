export ZSH=$HOME/.oh-my-zsh

# This makes it possible to scroll through man pages in iTerm2 with the trackpad in OSX 10.13+
export LESS=-R

export EDITOR='nano'
export SSH_KEY_PATH="~/.ssh/id_rsa"

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"

export GOSS_PATH="/usr/local/bin/goss"

# Default to Python3 for new virtual environments
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"

# Base URL for ZSH JIRA extension
export JIRA_URL="https://bluestatedigital.atlassian.net"

source $HOME/.path.zsh

# Load autocompletes
fpath=(~/.zsh/completion $fpath)

# Configure my Spaceship prompt
ZSH_THEME="spaceship"
source $HOME/.spaceship.zsh

# Enable ZSH plugins
plugins=(
    aws
    brew
    copyfile
    docker
    git
    jira
    osx
)

# Now load the ZSH shell
source $ZSH/oh-my-zsh.sh

# Source shell aliases
source $HOME/.aliases.zsh
[[ -e $HOME/.tesseract/.tessrc ]] && source $HOME/.tesseract/.tessrc
