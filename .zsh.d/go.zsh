#!/bin/zsh

if has goenv; then
    path=(
        $HOME/.goenv/bin(N-/)
        $path
    )
fi
eval "$(goenv init -)"

e_done "setting go environment"
