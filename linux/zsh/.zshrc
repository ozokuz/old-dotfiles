source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

export EDITOR="nvim"

export PNPM_HOME="/home/ozoku/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PNPM_HOME:$PATH"

# Aliases

# Code Editing
alias c="code"
alias v="$EDITOR"
alias vf="fzf | xargs $EDITOR"

# Directory Listing
alias le="exa"
alias ll="le -l --icons"
alias l="ll -a"
alias lt="le -Ta --icons"
alias ltl="lt -l"

# Git
alias gs="git status"
alias gc="git commit"
alias ga="git add"
alias gap="git add -p"
alias gd="git diff"
alias gpl="git pull"
alias gps="git push"

# Other
alias cl="clear"

setopt auto_cd

bindkey -v
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

