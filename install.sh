#!/bin/bash
# Find the directory this script is in
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Install the latest version of lazygit
# https://github.com/jesseduffield/lazygit#ubuntu
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit

# Install desired Ubuntu packages
sudo apt update && \
  sudo apt install -y --no-install-recommends \
    vim \
    && \
  sudo apt-get purge -y && \
  sudo apt-get clean && rm -r /var/lib/apt/lists/*

# Set up vim
cp $SCRIPT_DIR/vim/vimrc ~/.vimrc
echo -e "# Set vim as default editor\nexport EDITOR=vim" | sudo tee -a /etc/profile.d/vim.sh > /dev/null

# Set up lazygit
mkdir -p ~/.config/lazygit
cp $SCRIPT_DIR/config/lazygit/config.yml ~/.config/lazygit/

# Copy scripts for installing zsh and prezto, but don't run them because zsh installs interactively
cp $SCRIPT_DIR/zsh/install_zsh.sh /tmp/install_zsh.sh
cp $SCRIPT_DIR/zsh/install_prezto.zsh /tmp/install_prezto.zsh
chmod +x /tmp/install_zsh.sh
chmod +x /tmp/install_prezto.zsh

echo "To install zsh and prezto, run /tmp/install_zsh.sh"
