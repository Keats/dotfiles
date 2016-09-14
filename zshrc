# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

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
source /usr/bin/virtualenvwrapper.sh


# For Go
export GOPATH=$HOME/Code/go
export PATH=$PATH:$GOPATH/bin

# For Rust
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
export PATH=$PATH:$HOME/.cargo/bin

alias subl='subl3'

# Saving installed packages in files
alias bacpac='pacman -Qqen > pkglist.txt'
alias bacpac-aur='pacman -Qqm > pkglist-aur.txt'
source /usr/share/nvm/init-nvm.sh
eval "$(direnv hook zsh)"

alias when="date '+%Y-%m-%d %H:%M'"

if [ -e /home/vincent/.nix-profile/etc/profile.d/nix.sh ]; then . /home/vincent/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
