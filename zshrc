# Basic {
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/apostergiou/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"
DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(debian web-search git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
# }

# User configuration {

export TERM=xterm-256color

# if you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# allows you to type Bash style comments on your command line
# good 'ol Bash
setopt interactivecomments

# Zsh has a spelling corrector
setopt CORRECT

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias tn='tmux -2 new'

# copy my public ssh key to system clipboard for pasting into Github
# pbcopy < ~/.ssh/id_rsa.pub
#
# # paste something I've copied from the internet to a file
# pbpaste > main.go
#
# # append something I've copied from the internet to the END a file
# pbpaste >> main.go
#
# # copy my public IP address to clipboard
# curl -Ss icanhazip.com | pbcopy
# # replace what is in my clipboard with the base64 encoded version of itself
# pbpaste | base64 | pbcopy
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# ls
alias ls='ls --color'
LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

# power off
alias shutdown="sudo shutdown 0"
alias reboot="sudo reboot 0"
alias suspend="systemctl suspend"

# zsh-autosuggestions
bindkey '^ ' autosuggest-accept

# open github page based on the remote.origin.url property of the git config
alias github=GitHub
function GitHub()
{
    if [ ! -d .git ] ;
        then echo "ERROR: This isnt a git directory" && return false;
    fi

    git_url=`git config --get remote.origin.url`
    git_domain=`echo $git_url | awk -v FS="(@|:)" '{print $2}'`
    git_branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`

    if [[ $git_url == https://* ]];
    then
        url=${git_domain}/${git_url%.git}/tree/${git_branch}
    else
       if [[ $git_url == git@* ]]
       then
            url="https://${git_domain}/${${git_url#*:}%.git}/tree/${git_branch}"
            echo $url
       else
           echo "ERROR: Remote origin is invalid" && return false;
       fi
    fi
    xdg-open $url
}

# }

# Languages {
# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
# bundle exec alias
alias bex="bundle exec"

# golang
#
export PATH=$PATH:/usr/local/go/bin
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH/bin"
alias cdgo="cd $GOPATH/src/"

# js
# load nvm
nvml() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
alias nvml='nvml'

# }

# fzf {
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias findz='find * -type f | fzf'

# fzf with preview window and code highlighting
fzf_preview() {
  fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                  echo {} is a binary file ||
                  (highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500'
}

# git preview
fzf_git_preview() {
  git log --pretty=oneline --abbrev-commit |
    fzf --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'
}

# fuzzy open with vim from anywhere
fzf_vim() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}

# cd to selected directory
fzf_cd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# cd to directory including hidden directories
fzf_cda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fuzzy cd from anywhere
# zsh autoload function
fzf_fcd() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# search file contents with ag, respects gitignore
fzf_search() {
  ag --nobreak --nonumbers --noheading . | fzf
}

# fkill - kill process
fzf_kill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
# }

unalias grv
