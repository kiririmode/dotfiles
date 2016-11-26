#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and constructed with many
# minimal functions.
. "$DOTPATH"/etc/lib/vital.sh

imports=(
    # An autocompletion daemon for the Go programming language
    github.com/nsf/gocode
    # Print where symbols are defined in Go source code
    github.com/rogpeppe/godef
    # Command goimports updates your Go import lines, adding missing ones and removing unreferenced ones.
    golang.org/x/tools/cmd/goimports
    # A tool for speedup goimports command
    github.com/monochromegane/dragon-imports/...
)

for i in ${imports[@]}; do
    if go get -u "$i"; then
        log_pass "$i is installed successfully"
    else
        log_fail "error: failed to install $i"
    fi
done
