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

if has "brew"; then
    log_pass "brew already installed"
    exit
fi

if ! has "ruby"; then
    log_fail "error: require ruby"
    exit
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
if has "brew"; then
    brew doctor
else
    log_fail "error: brew: failed to install"
    exit 1
fi

log_pass "brew: installed successfully"
