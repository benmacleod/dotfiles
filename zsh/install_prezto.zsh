#!/usr/bin/zsh
# Install prezto
# https://github.com/sorin-ionescu/prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Set some preferences
sed -i -e "/:prezto:module:prompt/ s/theme '\(.*\)'/theme 'steeef'/" ~/.zprezto/runcoms/zpreztorc

# Set VS Code as the default editor
EDITOR="code -w"
echo "export GIT_EDITOR=\"${EDITOR}\"" >> ~/.zshrc
echo "export EDITOR=\"${EDITOR}\"" >> ~/.zshrc
echo "export VISUAL=\"${EDITOR}\"" >> ~/.zshrc

# Set up alias for lazygit
echo "alias lg='lazygit'" >> ~/.zshrc
