# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# ls colours
eval $(dircolors ~/.dircolors)

ZSH_THEME="keats"
plugins=(git sprunge archlinux virtualenvwrapper)


source $ZSH/oh-my-zsh.sh
unset GREP_OPTIONS

# User configuration
unalias gb

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/bin/core_perl"
export LANG=en_GB.UTF-8

export EDITOR='vim'
export PULSE_LATENCY_MSEC=60

export WORKON_HOME=$HOME/.virtualenvs
# For Go
export GOPATH=$HOME/Code/go
export PATH=$PATH:$GOPATH/bin:$HOME/.multirust/toolchains/stable/cargo/bin

# For Rust
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
export RUST_SRC_PATH=/home/vincent/Github/rust/src
source /usr/bin/virtualenvwrapper.sh

alias subl='subl3'

# Saving installed packages in files
alias bacpac='pacman -Qqen > pkglist.txt'
alias bacpac-aur='pacman -Qqm > pkglist-aur.txt'
source /usr/share/nvm/init-nvm.sh
eval "$(direnv hook zsh)"

. /home/vincent/.nix-profile/etc/profile.d/nix.sh
