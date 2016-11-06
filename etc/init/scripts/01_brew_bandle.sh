#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and constructed with many
# minimal functions.
. "$DOTPATH"/etc/lib/vital.sh

if ! is_osx; then
    log_fail "error: this script is only supported with osx."
    exit 1
fi

if ! has "brew"; then
    log_fail "error: brew bundle: require brew"
    exit
fi

if ! brew tap Homebrew/bundle; then
    log_fail "error: failed to tap Homebrew/bundle"
    exit 1
fi

cd "$DOTPATH"/etc/init/assets/
if [ ! -f Brewfile ]; then
    brew bundle dump
fi

brew bundle

log_pass "brew: installed successfully"
