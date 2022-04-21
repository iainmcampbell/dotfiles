source ~/.zshrc_imports/oh-my-zsh

source ~/.zshrc_imports/git
source ~/.zshrc_imports/misc
source ~/.zshrc_imports/shopify

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
