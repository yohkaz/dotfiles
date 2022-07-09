#!/usr/bin/env bash
DIR=$(dirname -- "$( readlink -f -- "$0"; )")
ln -sfv $DIR/tmux/.tmux.conf ~/.tmux.conf
ln -sfv $DIR/nvim/ ~/.config/
