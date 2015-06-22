# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

ZSH_THEME="keats"
plugins=(git sprunge archlinux virtualenvwrapper)

source $ZSH/oh-my-zsh.sh
wmname LG3D

unset GREP_OPTIONS

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export LANG=en_GB.UTF-8

export EDITOR='vim'
export PULSE_LATENCY_MSEC=60

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# For fig
export DOCKER_HOST=tcp://localhost:4243
export ANDROID_HOME=$HOME/android-sdk
export WORKON_HOME=$HOME/.virtualenvs
# For Rust
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
export RUST_SRC_PATH=/home/vincent/Github/rust/src
source /usr/bin/virtualenvwrapper.sh

alias subl='subl3'
alias android='/opt/android-sdk/tools/android'

