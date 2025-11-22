#!/bin/bash

trap 'echo Error: $0:$LINENO stopped.' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

function install_blogsync() {
    local blogsync_ver="v0.20.1"
    local arch="amd64"

    # ARM Mac対応
    if [[ "$(uname -m)" == "arm64" ]]; then
        arch="arm64"
    fi

    # $HOME/bin がシンボリックリンクの場合、リンク先を作成
    if [[ -L "$HOME/bin" ]]; then
        mkdir -p "$(readlink "$HOME/bin")"
    else
        mkdir -p "$HOME/bin"
    fi
    log_info "installing blogsync ${blogsync_ver}..."
    curl --progress-bar --location --output "${TMPDIR:-/tmp/}blogsync.zip" \
        "https://github.com/x-motemen/blogsync/releases/download/${blogsync_ver}/blogsync_${blogsync_ver}_darwin_${arch}.zip"
    unzip -oj "${TMPDIR:-/tmp/}blogsync.zip" "blogsync_${blogsync_ver}_darwin_${arch}/blogsync" -d "$HOME/bin"
    e_done "blogsync ${blogsync_ver}"
}

if is_osx; then
    install_blogsync
else
    log_pass "go-tools: skipped (not macOS)"
fi
