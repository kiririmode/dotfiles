#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

if ! is_osx; then
    log_pass "brew bundle: skipped (not macOS)"
    exit 0
fi

if ! has "brew"; then
    log_fail "error: brew bundle: require brew"
    exit 1
fi

cd "$DOTPATH"/etc
if [ ! -f Brewfile ]; then
    log_fail "error: Brewfile not found"
    exit 1
fi

brew bundle install --verbose
brew cleanup --verbose

log_pass "brew bundle: installed successfully"
