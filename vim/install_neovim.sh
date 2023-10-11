#!/bin/bash

set -e

# Build neovim from source
# From https://github.com/neovim/neovim/wiki/Building-Neovim

# Pre-reqs
sudo apt-get install ninja-build gettext cmake unzip curl
sudo apt-get install clang cmake build-essential gcc

# Clone, build, install
git clone https://github.com/neovim/neovim ~/external_repos/neovim
cd ~/external_repos/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
