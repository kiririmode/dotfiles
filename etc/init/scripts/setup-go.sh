#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/vital.sh

readonly GO_VERSION=1.13.5

if goenv versions | grep ${GO_VERSION} >/dev/null; then
    : # noop
else
    goenv install ${GO_VERSION}
    goenv rehash
fi

goenv global ${GO_VERSION} >/dev/null
e_done "setting golang ${GO_VERSION} environment."
