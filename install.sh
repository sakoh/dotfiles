#!/bin/bash

cp -r config/* $HOME/.config/
cp -r Pictures $HOME/
#cp etc/pulse/default.pa /etc/pulse/default.pa
#cp etc/xdg/picom.conf /etc/xdg/picom.conf
mkdir $HOME/.fonts
cp fonts/* $HOME/.fonts/
cp zprofile $HOME/.zprofile
cp zshrc $HOME/.zshrc
cp xinitrc $HOME/.xinitrc
cp p10k.zsh $HOME/.p10k.zsh
cp tmux.conf $HOME/.tmux.conf
cp dwmblocks $HOME/.dwmblocks
cp vimrc $HOME/.vimrc
