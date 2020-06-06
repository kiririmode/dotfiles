#!/bin/bash

trap 'echo Error: $0:$LINENO stopped.' ERR INT
set -eu
source $DOTPATH/etc/lib/vital.sh

readonly BIN_DIR="$HOME/bin"

function install_blogsync() {
    readonly BLOGSYNC_VER="v0.10.3"
    log_info "installing blogsync ${BLOGSYNC_VER}..."
    curl --progress-bar --location --output "${TMPDIR}blogsync.zip" --remote-name https://github.com/motemen/blogsync/releases/download/${BLOGSYNC_VER}/blogsync_${BLOGSYNC_VER}_darwin_amd64.zip
    unzip -oj "${TMPDIR}blogsync.zip" blogsync_${BLOGSYNC_VER}_darwin_amd64/blogsync -d $HOME/bin
    e_done "blogsync ${BLOGSYNC_VER}"
}

install_blogsync
