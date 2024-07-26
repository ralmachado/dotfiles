#!/bin/bash

ln -fs $PWD/.gitconfig ~/.gitconfig
ln -fs $PWD/.zshrc ~/.zshrc

for dir in .config/*; do
  mkdir -p "$HOME/$dir"
done

for file in .config/*/*; do
  ln -fs $PWD/$file $HOME/$file
done

if [ ! -d $HOME/.config/alacritty/themes ]; then
  git clone https://github.com/alacritty/alacritty-theme $HOME/.config/alacritty/themes
done

