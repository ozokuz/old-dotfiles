source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug load

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias c="code"
alias v="$EDITOR"
alias le="exa"
alias ll="le -l --icons"
alias l="ll -a"
alias lt="le -Ta --icons"
alias ltl="lt -l"
alias gs="git status"
alias gc="git commit"
alias ga="git add"
alias gpl="git pull"
alias gps="git push"
alias vf="fzf | xargs $EDITOR"

setopt auto_cd

bindkey -v
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

eval "$(starship init zsh)"