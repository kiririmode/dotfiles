#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

if ! is_osx; then
    log_pass "fonts: skipped (not macOS)"
    exit 0
fi

# Rictyフォントをインストール
if [[ -d /usr/local/opt/ricty/share/fonts ]]; then
    cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
    fc-cache -vf
    log_pass "fonts: installed successfully"
elif [[ -d /opt/homebrew/opt/ricty/share/fonts ]]; then
    cp -f /opt/homebrew/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
    fc-cache -vf
    log_pass "fonts: installed successfully"
else
    log_info "fonts: ricty not found, skipping"
fi
