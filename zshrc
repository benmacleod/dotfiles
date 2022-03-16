#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# use Vim
export VISUAL=vim
export EDITOR="$VISUAL"

# Display window titles correctly in tmux(inator)
# https://github.com/tmuxinator/tmuxinator#window-names-are-not-displaying-properly
export DISABLE_AUTO_TITLE=true

# https://github.com/jesseduffield/lazygit#changing-directory-on-exit
lg() {
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

  lazygit "$@"

  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  fi
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ben/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ben/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ben/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ben/google-cloud-sdk/completion.zsh.inc'; fi

# Help python find openssl 1.1.1 when using gcloud
# https://stackoverflow.com/a/70555005/85000
export LD_LIBRARY_PATH=/usr/local/lib

# Load autocompletions
# https://cli.github.com/manual/gh_completion
autoload -U compinit
compinit -i
