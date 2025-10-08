set -q MY_ABBRS_INITIALIZED; and return

abbr -a -- ll 'ls -lGFh'
abbr -a -- gitdel 'git branch | grep -v "main\|master\" | xargs git branch -D'

# no need to run over-and-over
set -g MY_ABBRS_INITIALIZED true