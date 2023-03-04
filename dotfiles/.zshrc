# This makes it possible to scroll through man pages in iTerm2 with
# the trackpad in OSX 10.13+
export LESS=-R

# It's like vi but better!
export EDITOR='nano'

export ZSH=$HOME/.oh-my-zsh

source $HOME/.path.zsh

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

# # Now load the ZSH shell
source $ZSH/oh-my-zsh.sh

# Source shell aliases
source $HOME/.aliases.zsh

# Load NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# [ -s "$HOME/.zsh_completion" ] && source $HOME/.zsh_completion
