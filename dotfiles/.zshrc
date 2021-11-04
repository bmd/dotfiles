export ZSH=$HOME/.oh-my-zsh

# This makes it possible to scroll through man pages in iTerm2 with
# the trackpad in OSX 10.13+
export LESS=-R

# It's like vi but better!
export EDITOR='nano'

export SSH_KEY_PATH="$HOME/.ssh/id_rsa"

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"

export GOSS_PATH="/usr/local/bin/goss"

# Base URL for ZSH JIRA extension
export JIRA_URL=""

source $HOME/.path.zsh

# Load autocompletes
fpath=($HOME/.zsh/completion $fpath)

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

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Kubectl completion
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export PATH="/opt/homebrew/opt/elasticsearch@6/bin:$PATH"
