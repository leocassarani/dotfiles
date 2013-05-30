# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Display red dots to be while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rails3 git ruby bundler gem osx rake rbenv)

source $ZSH/oh-my-zsh.sh

# Disable autocorrect
unsetopt correct_all

# Display a full range of colours
export TERM=xterm-256color

# Set up default PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/texbin

# Add rbenv and Cabal binaries
export PATH="$HOME/.rbenv/bin:$HOME/.cabal/bin:$PATH"

export EDITOR=vi

eval "$(rbenv init -)"

# Misc aliases
alias ll="ls -la"
alias sr="screen -r"

# Load the script containing my aliases for SSH'ing into various servers
[[ -s "$HOME/.ssh/aliases" ]] && source "$HOME/.ssh/aliases"

# Ruby/Railsy aliases
alias migrate="rake db:migrate && rake db:test:prepare"
alias be="bundle exec"
alias r="bundle exec rails"
alias brake="bundle exec rake"

ve() {
  cmd=$*
  vagrant ssh -c "cd /vagrant && $cmd"
}

export VIMCLOJURE_SERVER_JAR="/usr/local/lib/vimclojure/server-2.3.6.jar"

# Add the Homebrew-installed version of OpenSSL to my build variables
LDFLAGS="-L/usr/local/opt/openssl/lib $LDFLAGS"
CPPFLAGS="-I/usr/local/opt/openssl/include $CPPFLAGS"
