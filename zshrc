export ZSH="/Users/leo/.oh-my-zsh"

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias sr="screen -r"
alias vg=vagrant
alias tma="tmux attach -d -t"
alias ll="ls -lha"

export CDPATH=".$HOME:$HOME/code:$GOPATH/src/github.com/leocassarani"
export LC_ALL=$LANG

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

alias hueon="hueadm group 1 on"
alias hueoff="hueadm group 1 off"
