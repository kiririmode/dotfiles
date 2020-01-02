#!/bin/zsh

if has nodeenv; then
    path=(
        $HOME/.nodenv/bin(N-/)
        $path
    )
fi
eval "$(nodenv init -)"

e_done "setting node environment"
