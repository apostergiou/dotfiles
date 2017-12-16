# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}'
    local user_symbol='%{$terminfo[bold]$fg[red]%}%#%{$reset_color%}'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}'
    local user_symbol='%{$terminfo[bold]$fg[green]%}$%{$reset_color%}'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local ruby=''
if which rvm-prompt &> /dev/null; then
  ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

# PROMPT="╭─${user_host} ${git_branch}
# ╰─%B${user_symbol}%b "

PROMPT="[%T] ${git_branch}${user_symbol} "

RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
