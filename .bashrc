# Run starship prompt
eval "$(starship init bash)"

# C-w delete word by word
stty werase undef
bind '"\C-w":backward-kill-word'

export GIT_EDITOR=vim
