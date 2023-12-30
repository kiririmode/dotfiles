#!/bin/zsh

if has jenv; then
    path=(
        $HOME/.jenv/bin(N-/)
        $path
    )
fi
eval "$(jenv init -)"

e_done "setting java environment"
