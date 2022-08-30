#!/bin/bash
# zsh needs to be installed interactively, so we'll keep this script separate from the rest of the install script

# Install zsh, keeping the default config, and set it as our preferred shell
sudo apt update \
  && sudo apt install zsh -y
chsh -s $(which zsh)

# Install prezto
zsh -c "/tmp/install_prezto.zsh"