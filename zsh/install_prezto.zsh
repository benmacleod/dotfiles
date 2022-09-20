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

# Set vim as default editor
echo "export EDITOR=vim" >> ~/.zshrc
echo "export VISUAL=vim" >> ~/.zshrc