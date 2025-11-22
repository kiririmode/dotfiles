# =============================================================================
# Aliases
# =============================================================================

# -----------------------------------------------------------------------------
# Safety
# -----------------------------------------------------------------------------
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# -----------------------------------------------------------------------------
# ls
# -----------------------------------------------------------------------------
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias l='ls -CF'

# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# -----------------------------------------------------------------------------
# Directory navigation
# -----------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

alias mkdir='mkdir -pv'

# -----------------------------------------------------------------------------
# Disk usage
# -----------------------------------------------------------------------------
alias df='df -h'
alias du='du -h'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# -----------------------------------------------------------------------------
# Process
# -----------------------------------------------------------------------------
alias psg='ps aux | grep -v grep | grep'

# -----------------------------------------------------------------------------
# Network
# -----------------------------------------------------------------------------
alias myip='curl -s ifconfig.me'
alias localip="ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -1"
alias ports='ss -tulanp'

# -----------------------------------------------------------------------------
# AWS CLI
# -----------------------------------------------------------------------------
alias awsid='aws sts get-caller-identity'
alias awswho='aws sts get-caller-identity --query Account --output text'

# -----------------------------------------------------------------------------
# ghq + peco
# -----------------------------------------------------------------------------
alias repo='cd $(ghq list -p | peco)'
alias repos='ghq list -p | peco | xargs code'

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------
alias h='history'
alias hg='history | grep'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
alias reload='exec $SHELL -l'
alias cls='clear'

# tree with sensible defaults
alias tree='tree -C --dirsfirst'
alias t='tree -L 2'
alias t3='tree -L 3'

# less with color
alias less='less -R'

# Make with parallel jobs
alias make='make -j$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 1)'

# -----------------------------------------------------------------------------
# Quick edit configs
# -----------------------------------------------------------------------------
alias zshrc='${EDITOR:-vim} ~/.zshrc'
alias vimrc='${EDITOR:-vim} ~/.vimrc'
alias gitconfig='${EDITOR:-vim} ~/.gitconfig'

# -----------------------------------------------------------------------------
# Suffix aliases (open files with specific programs)
# -----------------------------------------------------------------------------
alias -s {md,markdown,txt}=${EDITOR:-vim}
alias -s {html,htm}='open'
alias -s {pdf}='open'
alias -s {json}='jq .'

# -----------------------------------------------------------------------------
# Global aliases
# -----------------------------------------------------------------------------
alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g J='| jq .'
alias -g C='| wc -l'
alias -g N='> /dev/null 2>&1'
alias -g Y='| pbcopy'
