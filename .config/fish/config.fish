if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/vincent/.lmstudio/bin
# End of LM Studio CLI section


fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
alias claude="/home/vincent/.claude/local/claude"
starship init fish | source
