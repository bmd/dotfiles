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

source $HOME/.path.zsh

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

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
    # poetry
)

# Now load the ZSH shell
source $ZSH/oh-my-zsh.sh

# Source shell aliases
source $HOME/.aliases.zsh

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"

eval "$(rbenv init - zsh)"

source $HOME/.zsh_completion
