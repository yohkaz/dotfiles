# Run starship prompt
DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
export STARSHIP_CONFIG=$DIR/starship.toml
eval "$(starship init bash)"

# C-w delete word by word
stty werase undef
bind '"\C-w":backward-kill-word'

export GIT_EDITOR=vim
