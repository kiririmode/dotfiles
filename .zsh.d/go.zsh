#!/bin/zsh

if has goenv; then
    path=(
        $HOME/.goenv/bin(N-/)
        $GOPATH/bin
        $path
    )
fi
eval "$(goenv init -)"

typeset -xT GOPATH gopath
typeset -U gopath
gopath=(
    $gopath
    $HOME
)

e_done "setting go environment"
