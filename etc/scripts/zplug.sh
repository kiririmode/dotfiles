#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

ZPLUG_HOME="${ZPLUG_HOME:-$HOME/.zplug}"
if [[ -d "$ZPLUG_HOME" ]]; then
    log_pass "zplug: already installed"
    exit 0
fi

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

log_pass "zplug: installed successfully"
