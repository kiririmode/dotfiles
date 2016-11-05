#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and constructed with many
# minimal functions.
. "$DOTPATH"/etc/lib/vital.sh

### install Tmux Plugin Manager: https://github.com/tmux-plugins/tpm
function install_tpm() {
    local install_dir="$HOME/.tmux/plugins/tpm"

    if [[ -d "$install_dir" ]]; then
        log_info "$install_dir already exists.  delete it."
        rm -rf $install_dir
    fi
    git clone https://github.com/tmux-plugins/tpm $install_dir
}

install_tpm;
log_pass "install Tmux Plugin Manager"
