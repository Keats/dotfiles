# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

ZSH_THEME="keats"
plugins=(git sprunge archlinux virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

unset GREP_OPTIONS

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export LANG=en_GB.UTF-8

export EDITOR='vim'
export PULSE_LATENCY_MSEC=60

# For fig
export DOCKER_HOST=tcp://localhost:4243
export ANDROID_HOME=~/Android/Sdk
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

alias subl='subl3'
alias charm='sh /home/vincent/Apps/pycharm/bin/pycharm.sh'
