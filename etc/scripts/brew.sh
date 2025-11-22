#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

if ! is_osx; then
    log_pass "brew: skipped (not macOS)"
    exit 0
fi

if has "brew"; then
    log_pass "brew already installed"
    exit 0
fi

if ! has "ruby"; then
    log_fail "error: require ruby"
    exit 1
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if has "brew"; then
    brew doctor
else
    log_fail "error: brew: failed to install"
    exit 1
fi

log_pass "brew: installed successfully"
