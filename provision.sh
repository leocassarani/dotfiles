#!/usr/bin/env bash

set -e

USER=vagrant
PASSWORD=vagrant

export CODE_DIR=$HOME/code
export GOPATH=$CODE_DIR/golang
export GOROOT=$CODE_DIR/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

function apt_get_update() {
  # We only want to do this on the very first run.
  if [ ! -f $HOME/.apt_get_last_updated ]; then
    sudo apt-get update
    date "+%s" > $HOME/.apt_get_last_updated
  fi
}

function clone_and_link_dotfiles() {
  sudo apt-get install -y git
  mkdir -p $CODE_DIR

  if [ ! -d $CODE_DIR/dotfiles ]; then
    git clone git://github.com/leocassarani/dotfiles.git $CODE_DIR/dotfiles
    cd $CODE_DIR/dotfiles

    git submodule init
    git submodule update

    # Change the remote to one we can push to.
    git remote set-url origin "git@github.com:leocassarani/dotfiles.git"
  fi

  if [ ! -f ~/.gitconfig ];        then ln -s $CODE_DIR/dotfiles/gitconfig ~/.gitconfig;               fi
  if [ ! -f ~/.gitignore_global ]; then ln -s $CODE_DIR/dotfiles/gitignore_global ~/.gitignore_global; fi
  if [ ! -f ~/.tmux.conf ];        then ln -s $CODE_DIR/dotfiles/tmux.conf ~/.tmux.conf;               fi
  if [ ! -f ~/.vimrc ];            then ln -s $CODE_DIR/dotfiles/vimrc ~/.vimrc;                       fi
  if [ ! -d ~/.vim ];              then ln -s $CODE_DIR/dotfiles/.vim ~/.vim;                          fi
  if [ ! -f ~/.zshrc ];            then ln -s $CODE_DIR/dotfiles/zshrc ~/.zshrc;                       fi
}

function install_zsh() {
  sudo apt-get install -y git zsh

  if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    echo $PASSWORD | chsh -s /bin/zsh
  fi
}

function install_vim() {
  sudo apt-get install -y python-software-properties

  if [ ! -f /etc/apt/sources.list.d/fcwu-tw-ppa-precise.list ]; then
    sudo add-apt-repository ppa:fcwu-tw/ppa
    sudo apt-get update
  fi

  sudo apt-get install -y vim
}

function install_tmux() {
  sudo apt-get install -y python-software-properties

  if [ ! -f /etc/apt/sources.list.d/pi-rho-dev-precise.list ]; then
    sudo add-apt-repository ppa:pi-rho/dev
    sudo apt-get update
  fi

  sudo apt-get install -y tmux
}

function install_dev_tools() {
  sudo apt-get install -y curl wget exuberant-ctags htop
  install_the_silver_searcher
}

function install_the_silver_searcher() {
  sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev

  AGDIR=/tmp/the_silver_searcher

  if [ ! $(which ag) ]; then
    git clone git://github.com/ggreer/the_silver_searcher.git $AGDIR
    cd $AGDIR

    ./build.sh
    sudo make install

    rm -rf $AGDIR
    cd
  fi
}

function install_go() {
  sudo apt-get install -y mercurial

  if [ ! $(which go) ]; then
    if [ ! -d $GOROOT ]; then
      hg clone -u release https://code.google.com/p/go $GOROOT
    fi

    cd $GOROOT/src
    ./all.bash
  fi

  mkdir -p $GOPATH

  go get code.google.com/p/go.tools/cmd/goimports
  go get github.com/golang/lint/golint
  go get golang.org/x/tools/cmd/vet
}

function install_ruby() {
  sudo apt-get install -y python-software-properties

  if [ ! -f /etc/apt/sources.list.d/brightbox-ruby-ng-precise.list ]; then
    sudo add-apt-repository ppa:brightbox/ruby-ng
    sudo apt-get update
  fi

  sudo apt-get install -y ruby2.1
}

function install_haskell() {
  sudo apt-get install -y libgmp10 libgmp-dev

  URL=https://www.haskell.org/platform/download/2014.2.0.0/haskell-platform-2014.2.0.0-unknown-linux-x86_64.tar.gz
  TARFILE=haskell-platform-2014.2.0.0-unknown-linux-x86_64.tar.gz

  if [ ! $(which ghc) ]; then
    if [ ! -f /tmp/$TARFILE ]; then
      cd /tmp
      wget --no-verbose $URL
    fi

    cd /
    sudo tar xf /tmp/$TARFILE
    sudo /usr/local/haskell/ghc-7.8.3-x86_64/bin/activate-hs
    rm /tmp/$TARFILE
  fi
}

function main() {
  apt_get_update
  clone_and_link_dotfiles
  install_zsh
  install_vim
  install_tmux
  install_dev_tools
  install_go
  install_ruby
  install_haskell
}

main
