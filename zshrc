source ~/.zshrc_imports/oh-my-zsh

source ~/.zshrc_imports/git
source ~/.zshrc_imports/misc
source ~/.zshrc_imports/shopify

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

if [ -d "/opt/homebrew/opt/chruby" ]; then
  source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
  chruby 3.2.1
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [ -d "/Applications/Sublime Text.app" ]; then
  export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
fi
