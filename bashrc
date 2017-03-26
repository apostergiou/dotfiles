if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
fi

export PS1='\[\033[38;5;2m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h\[$(tput sgr0)\]:\[\033[38;5;14m\][\w]\[$(tput sgr0)\]\[\033[38;5;11m\]$(__git_ps1)\[$(tput sgr0)\]\[\033[01;34m\] \n \$\[\033[00m\] '

alias ls='ls --color'
LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS
alias shutdown="sudo shutdown 0"
alias reboot="sudo reboot 0"
alias suspend="systemctl suspend"

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

# Do not record duplicate commands
export HISTCONTROL=ignoreboth:erasedups

## copy my public ssh key to system clipboard for pasting into Github
# pbcopy < ~/.ssh/id_rsa.pub
#
## paste something I've copied from the internet to a file
# pbpaste > main.go
#
## append something I've copied from the internet to the END a file
# pbpaste >> main.go
#
## copy my public IP address to clipboard
# curl -Ss icanhazip.com | pbcopy
#
## replace what is in my clipboard with the base64 encoded version of itself
# pbpaste | base64 | pbcopy
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias tn='tmux -2 new bash'
alias em='emacsclient -t'

export ALTERNATE_EDITOR=""
export PATH=$HOME/bin:$PATH
