#!/bin/zsh

trap 'echo Error: $0:$LINENO stopped: exit 1' ERR INT
set -eu

if has goenv; then
    path=(
        $HOME/.goenv/bin(N-/)
        $path
    )
fi
eval "$(goenv init -)"

e_done "setting go environment"
