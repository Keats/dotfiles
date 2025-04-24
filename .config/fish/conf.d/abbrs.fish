set -q MY_ABBRS_INITIALIZED; and return

abbr -a -- ll 'ls -lGFh'

# no need to run over-and-over
set -g MY_ABBRS_INITIALIZED true