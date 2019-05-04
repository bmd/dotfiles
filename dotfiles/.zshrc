export ZSH=$HOME/.oh-my-zsh

export EDITOR='nano'
export SSH_KEY_PATH="~/.ssh/id_rsa"

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"

export GOSS_PATH="/usr/local/bin/goss"

export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"

# Load autocompletes
fpath=(~/.zsh/completion $fpath)

# autoload -Uz compinit && compinit -i
# autoload -U +X bashcompinit && bashcompinit
# source ~/.zsh/completion/_tesseract

# Go Development
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# Set name of the theme to load.
#ZSH_THEME="bmd/bmd"
ZSH_THEME="spaceship"
source $HOME/.spaceship.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
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

# Aliases
[[ -e $HOME/.aliases ]] && source $HOME/.aliases
[[ -e $HOME/.tesseract/.tessrc ]] && source $HOME/.tesseract/.tessrc
