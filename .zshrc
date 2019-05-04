# Path to your dotfiles installation.
export DOTFILES=$HOME/git/dotfiles

export GOSS_PATH=/usr/local/bin/goss


DEFAULT_USER=`whoami`

source ~/.tesseract/.tessrc

export LESS=-R

### Autocomplete for docker
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
autoload -U +X bashcompinit && bashcompinit
source ~/.zsh/completion/_tesseract

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export GPG_TTY=$(tty)

# Go Development
export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# Set name of the theme to load.
#ZSH_THEME="bmd/bmd"
ZSH_THEME="spaceship"
source ~/.spaceship


SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ADD_NEWLINE=false

SPACESHIP_CHAR_SYMBOL="%F{071}❯ "
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_SUFFIX=""

SPACESHIP_DIR_COLOR="250"
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC=0

SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_EXEC_TIME_PREFIX="("
SPACESHIP_EXEC_TIME_SUFFIX=") "

SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX=""

SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_GIT_BRANCH_PREFIX="• "
SPACESHIP_GIT_BRANCH_SUFFIX=""
SPACESHIP_GIT_BRANCH_COLOR="240"

SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""

# We won't actually ever use this
SPACESHIP_GIT_STATUS_COLOR="red"

SPACESHIP_GIT_STATUS_UNTRACKED="%F{yellow}❯%F{red}"
SPACESHIP_GIT_STATUS_ADDED="%F{071}❯%F{red}"
SPACESHIP_GIT_STATUS_MODIFIED="❯"

SPACESHIP_GIT_STATUS_RENAMED=""
SPACESHIP_GIT_STATUS_DELETED=""
SPACESHIP_GIT_STATUS_STASHED=""
SPACESHIP_GIT_STATUS_UNMERGED=""
SPACESHIP_GIT_STATUS_AHEAD=""
SPACESHIP_GIT_STATUS_BEHIND=""
SPACESHIP_GIT_STATUS_DIVERGED=""

SPACESHIP_PHP_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=( git brew composer cap )

source $ZSH/oh-my-zsh.sh

# Aliases
[[ -e ~/.bashrc ]] && source ~/.bashrc
[[ -e ~/.aliases ]] && source ~/.aliases
[[ -e ~/.tesseract/.tessrc ]] && source ~/.tesseract/.tessrc

# Preferred editor for local and remote sessions
export EDITOR='nano'
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
