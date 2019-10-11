function prompt_char {
  git branch >/dev/null 2>/dev/null && echo "±" && return
  echo '○'
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

local current_dir='${PWD/#$HOME/~}'
local git_info='$(git_prompt_info)'
local prompt_char='$(prompt_char)'
local _lineup=$'\e[1A'
local _linedown=$'\e[1B'

precmd() { print "" }

RPROMPT=%{${_lineup}%}%{$FG[008]%}"%D{%d/%m/%Y - %H:%M:%S}"%{$reset_color%}%{${_linedown}%}

PROMPT="%{$FG[008]%}%n%{$FG[FFF]%}@%{$reset_color%}%{$terminfo[bold]$FG[FFF]%}$(box_name)%{$reset_color%}%{$FG[008]%} in%{$reset_color%} %{$terminfo[bold]$FG[012]%}${current_dir}%{$reset_color%}${git_info}%{$reset_color%}
${prompt_char} "

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[008]%}on%{$reset_color%} %{$fg[255]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[222]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[114]%}✔"
