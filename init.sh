#!/bin/sh
# Initializes the new checkout
#   1) checksout all submodules
#   2) links ../.vimrc

vim +PluginInstall +qall

ln -s vimrc ~/.vimrc
