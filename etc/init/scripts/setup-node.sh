#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/vital.sh

readonly NODE_VERSION=18.7.0

if nodenv versions | grep ${NODE_VERSION} >/dev/null; then
    : # noop
else
    nodenv install ${NODE_VERSION}
    nodenv rehash
fi

nodenv global ${NODE_VERSION} >/dev/null
e_done "setting node ${NODE_VERSION} environment."
