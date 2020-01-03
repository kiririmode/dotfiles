#!/bin/zsh

if has nodenv; then
    path=(
        $HOME/.nodenv/bin(N-/)
        $path
    )
fi
eval "$(nodenv init -)"

e_done "setting node environment"
