#!/bin/bash
# Find the directory this script is in
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Install the latest version of lazygit
# https://github.com/jesseduffield/lazygit#ubuntu
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

# Install the keys for the GitHub CLI (gh)
# https://cli.github.com/manual/installation#linux
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

# Install desired Ubuntu packages
sudo apt update && \
  sudo apt install -y --no-install-recommends \
    gh \
    inetutils-ping \
    vim \
    && \
  sudo apt-get purge -y && \
  sudo apt-get clean && rm -r /var/lib/apt/lists/*

# Install Ruby gems
$SCRIPT_DIR/ruby/install.sh

# Set up vim
cp $SCRIPT_DIR/vim/vimrc ~/.vimrc

# Set up lazygit
mkdir -p ~/.config/lazygit
cp $SCRIPT_DIR/config/lazygit/config.yml ~/.config/lazygit/

# Install zsh and prezto
cp $SCRIPT_DIR/zsh/install_zsh.sh /tmp/install_zsh.sh
cp $SCRIPT_DIR/zsh/install_prezto.zsh /tmp/install_prezto.zsh
chmod +x /tmp/install_zsh.sh
chmod +x /tmp/install_prezto.zsh
/tmp/install_zsh.sh

# Install common gitingore file
cp $SCRIPT_DIR/git/gitignore ~/.gitignore
