

# ZSH config
# ********************************************************

# Path to your oh-my-zsh installation.
export ZSH=/Users/imc/.oh-my-zsh
ZSH_THEME="robbyrussell"

# plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

source $ZSH/oh-my-zsh.sh


# iTerm
# ********************************************************

# disable shared history
# (https://superuser.com/questions/1245273/iterm2-version-3-individual-history-per-tab)
unsetopt inc_append_history
unsetopt share_history


# Shopify
# ********************************************************

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

if [ -e /Users/imc/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/imc/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

alias partners="DISABLE_SHOPIFY_INTERNAL_API_INTERCEPTOR=1 dev rails"
alias clobber="bin/rails tmp:cache:clear && bin/rails assets:clobber"

alias npm_registry_shopify="npm config set @shopify:registry https://packages.shopify.io/shopify/node/npm/"
alias npm_registry_public="npm config set @shopify:registry https://registry.yarnpkg.com"

alias cli-dev="/Users/imc/src/github.com/Shopify/shopify-app-cli/bin/shopify"

alias clean="yarn run sewing-kit clean --vendor-dll"

# Spin

spin_install_subs() {
ssh $1.iain-campbell.us.spin.dev <<ENDSSH
cat <<EOT | bin/rails c

shop = Shop.find_by(name: 'Shop 1')

# Install Subscription App
api_client = ApiClient.find_by(id: 2525000000)
Apps::Installations::EnsureInstalled.perform(
    app_id: api_client.id,
    shop_id: shop.id,
    access_scope: Access::Scope.for_client(api_client, shop).map(&:to_s)
)

# Enable beta flags
shop.beta.enable 'argo_extensions_shops'
shop.beta.enable 'argo_extensions_dev_portal'

EOT

# Seed selling plan group for Subscription
bin/rails dev:subscriptions:create_selling_plan_group

ENDSSH
}





alias test="yarn test --watch"


# Git
# ********************************************************

alias g='git'

alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'

alias gc='git checkout'
alias gcb='git checkout -b'
alias gco='git checkout $(git branch | grep -v "\*" | fzf)'

alias gcp='git cherry-pick'

alias gam='git commit --amend -C HEAD'

# undo last commit & stage changes
alias gundo='git reset HEAD^'

alias difftool='git difftool HEAD HEAD~1 --tool=opendiff'
alias mergetool='git mergetool --tool=opendiff'
alias branch-diff='git diff $(git merge-base HEAD origin/master)'

alias git-remove-branches='alias git-rmb="git branch | grep -v "master" | xargs git branch -D"'

# check out a detached branch from origin when testing PRs,
# to not clutter up your git branches
tophat() {
  git fetch origin $1
  git checkout origin/$1
}

gitreset() {
  HEAD=$(git rev-parse --abbrev-ref HEAD)
  git fetch origin $HEAD
  git reset --hard origin/$HEAD
}

resetmaster() {
  git fetch origin master
  git reset --hard origin/master
}


port_pids() {
  lsof -nP -i4TCP:$1 | grep LISTEN
}


# remove all branches that don't match whitelist argument
# git_cleanup_branches "but-not-these-*"
alias branch='git rev-parse --abbrev-ref HEAD'

cleanup_branches() {

  if [ -n "$1" ]; then
    branches=$(git branch | grep -v -e "master" -e $1)
  else
    branches=$(git branch | grep -v "master")
  fi

  echo "Branches to delete:\n"
  echo $branches
  echo "\n"

  read -q "REPLY?Delete these branches [y/n]? "

  echo "\n"

  if [ $REPLY = 'y' ]; then
    # echo $branches | xargs echo
    echo $branches | xargs git branch -D
    echo 'Done.'
  else
    echo 'Ok, not deleting anything.'
  fi

}

# Opens the github page for the current git repository in your browser
# https://jasonneylon.wordpress.com/2011/04/22/opening-github-in-your-browser-from-the-terminal/
gh() {
  gitremote="$1"
  if [ -n "$1" ]; then
    gitremote="origin"
  fi

  giturl=$(git config --get remote.$gitremote.url)

  if [ -n "$giturl" ]; then
    echo "Not a git repository or no remote.origin.url set"
    exit 1
  fi

  # what branch are we on?
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}

  # if [[ $giturl = *"github"* ]]; then
    giturl=${giturl/git\@github\.com\:/https://github.com/}
      # giturl=${giturl/\.git/}
    # giturl=$giturl/tree/$branch

  # elif [[ $giturl = *"bitbucket"* ]]; then
  #   giturl=${giturl/git\@bitbucket\.org\:/https://bitbucket.org/}
  #   giturl=${giturl/\.git/}
  #   giturl=$giturl/branch/$branch

  # fi

  echo $giturl
  #open $giturl
}

