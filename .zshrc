# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="af-magic"
plugins=(git sprunge archlinux virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

unset GREP_OPTIONS

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export LANG=en_GB.UTF-8

EDITOR='vim'

# For fig
export DOCKER_HOST=tcp://localhost:4243

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Remove backgrounds for the folders etc
eval $(dircolors -b "$HOME/.dircolors")
