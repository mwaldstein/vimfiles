#!/bin/sh
# Initializes the new checkout
#   1) checksout all submodules
#   2) links ../.vimrc

git submodule update --init
ln -s vimrc ~/.vimrc
