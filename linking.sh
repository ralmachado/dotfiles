#!/bin/bash

# .dotfiles
# ln -fs ~/.dotfiles/.vimrc ~/.vimrc
ln -fs $PWD/.zshrc ~/.zshrc
ln -fs $PWD/.gitconfig ~/.gitconfig;
mkdir -p ~/.config/nvim && ln -fs $PWD/init.lua ~/.config/nvim/init.lua

