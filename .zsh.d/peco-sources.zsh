# -*- mode: shell-script -*-

function peco-ghq-src() {
    local selected_dir=$(ghq list --full-path | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq-src
bindkey '^X^Z' peco-ghq-src


function peco-git-branches() {
    local res=$(git branch -a | sed 's/^\*/ /' | awk '{ print $1 }' | peco)
    BUFFER+=$res
    zle clear-screen
}
zle -N peco-git-branches
bindkey '^X^B' peco-git-branches


function peco-git-files() {
    local res=$(git ls-files | peco)
    BUFFER+=$res
    zle clear-screen
}
zle -N peco-git-files
bindkey '^X^F' peco-git-files


function peco-select-history() {
    local tac
    tac=${commands[tac]:-"tail -r"}

    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r'   peco-select-history


function peco-z-search {
    local z
    z=${commands[z]}

    local res=$(z | sort -rn | cut -c 12- | peco)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}
zle -N peco-z-search
bindkey '^X^V' peco-z-search
