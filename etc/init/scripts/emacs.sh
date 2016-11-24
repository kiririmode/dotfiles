#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and constructed with many
# minimal functions.
. "$DOTPATH"/etc/lib/vital.sh

function install_cask() {
    local caskdir

    caskdir="$HOME"/.cask

    if [ -d $caskdir ]; then
        log_info "$HOME/.cask already exists."
    else
        git clone https://github.com/cask/cask.git $HOME/.cask
        log_info "installed cask successfully"
    fi

    log_info "installing emacs lisp files ..."
    cd "$DOTPATH"/.emacs.d/
    $caskdir/bin/cask install
    $caskdir/bin/cask update
    log_info "installed emacs lisp files successfully."

}

install_cask

# cask upgrade-cask
# cask --path "$DOTPATH"/etc/init/assets install
