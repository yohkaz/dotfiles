#!/usr/bin/env bash
if [ -z "$(command -v 'starship')" ]
then
    echo "install starship prompt"
    curl -sS https://starship.rs/install.sh | sh
    # uninstall command:
    # ```
    # sh -c 'rm "$(command -v 'starship')"'
    # ```
fi
DIR=$(dirname -- "$( readlink -f -- "$0"; )")
echo -n "install starship config: "
ln -sfv $DIR/starship.toml ~/.config/
echo -n "install tmux config: "
ln -sfv $DIR/tmux/ ~/.config/
echo -n "install neovim config: "
ln -sfv $DIR/nvim/ ~/.config/
grep -qxF "source $DIR/.bashrc" ~/.bashrc || (echo "install bash config: append 'source $DIR/.bashrc' to '~/.bashrc'" && echo "source $DIR/.bashrc" >> ~/.bashrc)
echo ""
echo "require to install also: `ripgrep`(telescope plugin), `npm` (tsserver), `unzip` (clangd), `python3-venv` (autopep8)"
echo "run 'source ~/.bashrc' and reload tmux, neovim to apply install"
