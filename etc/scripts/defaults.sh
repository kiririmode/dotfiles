#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

if ! is_osx; then
    log_pass "defaults: skipped (not macOS)"
    exit 0
fi

# show hidden files in Finder app.
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder || true

# スクリーンショットを配置する場所を変更する
mkdir -p ~/Pictures/screenshot
defaults write com.apple.screencapture location ~/Pictures/screenshot
killall SystemUIServer || true

log_pass "defaults: configured successfully"
