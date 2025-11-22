#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

# install Tmux Plugin Manager: https://github.com/tmux-plugins/tpm
function install_tpm() {
    local install_dir="$HOME/.tmux/plugins/tpm"

    if [[ -d "$install_dir" ]]; then
        log_pass "tpm: already installed"
        exit 0
    fi

    mkdir -p "$HOME/.tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm "$install_dir"
}

install_tpm
log_pass "tpm: installed successfully"
