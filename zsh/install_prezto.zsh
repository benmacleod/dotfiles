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

echo "# Set VS Code as the default editor" >> ~/.zshrc
EDITOR="code -w"
echo "export GIT_EDITOR=\"${EDITOR}\"" >> ~/.zshrc
echo "export EDITOR=\"${EDITOR}\"" >> ~/.zshrc
echo "export VISUAL=\"${EDITOR}\"" >> ~/.zshrc

echo "# Set up alias for lazygit" >> ~/.zshrc
echo "alias lg='lazygit'" >> ~/.zshrc

echo "# Ensure we use the gcloud auth plugin for kubectl" >> ~/.zshrc
echo "# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke" >> ~/.zshrc
echo "export USE_GKE_GCLOUD_AUTH_PLUGIN=True" >> ~/.zshrc

echo "# Set up autocomplete for kubectl" >> ~/.zshrc
echo "[[ $commands[kubectl] ]] && source <(kubectl completion zsh)" >> ~/.zshrc

echo "# Ensure npm's global bin dir is in our PATH" >> ~/.zshrc
echo "export PATH=\"\$PATH:\$(npm config get prefix 2>/dev/null)/bin\"" >> ~/.zshrc

echo "# Set the DISPLAY environment variable so GUI apps can connect to the host" >> ~/.zshrc
echo "export DISPLAY=\"host.docker.internal:0\"" >> ~/.zshrc
echo "# So we can connect to a bastion proxy running on the host" >> ~/.zshrc
echo "export BASTION_PROXY=\"host.docker.internal:8888\"" >> ~/.zshrc