#!/bin/bash

if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles
    export DOTPATH
fi

DOTFILES_GITHUB="https://github.com/kiririmode/dotfiles.git"; export DOTFILES_GITHUB

dotfiles_logo='
      | |     | |  / _(_) |
    __| | ___ | |_| |_ _| | ___  ___
   / _` |/ _ \| __|  _| | |/ _ \/ __|
  | (_| | (_) | |_| | | | |  __/\__ \
   \__,_|\___/ \__|_| |_|_|\___||___/
  *** WHAT IS INSIDE? ***
  1. Download https://github.com/kiririmode/dotfiles.git
  2. Symlinking dot files to your home directory
  3. Execute all sh files within `etc/init/` (optional)
  See the README for documentation.
  https://github.com/kiririmode/dotfiles
  Copyright (c) 2016 @kiririmode
  Licensed under the MIT license.
'

function is_debug() {
    if [ "$DEBUG" = 1 ]; then
        return 0
    else
        return 1
    fi
}

function is_interactive() {
    # $- が i を含んでいたら interactive shell を意味する
    if [ "${-/i/}" != "$-" ]; then
        return 0
    fi
    return 1
}

lower() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

function ostype() {
    uname | lower
}

function os_detect() {
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  PLATFORM='linux'   ;;
        *'darwin'*) PLATFORM='osx'     ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *)          PLATFORM='unknown' ;;
    esac
}

function is_osx() {
    os_detect
    if [ "$PLATFORM" = "osx" ]; then
        return 0
    else
        return 1
    fi
}
alias is_mac=is_osx

function is_linux() {
    os_detect
    if [ "$PLATFORM" = "linux" ]; then
        return 0
    else
        return 1
    fi
}

function is_bsd() {
    os_detect
    if [ "$PLATFORM" = "bsd" ]; then
        return 0
    else
        return 1
    fi
}



function get_os() {
    local os
    for os in osx linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}

function has() {
    which "$1" > /dev/null 2>&1
    return $?
}

function e_error() {
    printf " \033[31m%s\033[m\n" "$*" 1>&2
}

function e_newline() {
    printf "\n"
}

function e_header() {
    printf " \033[37;1m%s\033[m\n" "$*"
}

function e_error() {
    printf " \033[31m%s\033[m\n" "✖ $*" 1>&2
}

function e_warning() {
    printf " \033[31m%s\033[m\n" "$*"
}

function e_done() {
    printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
}

function e_arrow() {
    printf " \033[37;1m%s\033[m\n" "➜ $*"
}

function e_indent() {
    for ((i=0; i<$(1:-4); i++)); do
        echon " "
    done
    if [ -n "$2" ]; then
        echo "$2"
    else
        cat <&0
    fi
}

function e_success() {
    printf " \033[37;1m%s\033[m%s...\033[32mOK\033[m\n" "✔ " "$*"
}

function e_failure() {
    die "${1:-$FUNCNAME}"
}

function ink() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <color> <text>"
        echo "Colors"
        echo "  black, white, red, green, yellow, blue, purple, cyan, gray"
    fi

    local open="\033["
    local close="${open}0m"
    local black="0;30m"
    local red="1;31m"
    local green="1;32m"
    local yellow="1;33m"
    local blue="1;34m"
    local purple="1;35m"
    local cyan="1;36m"
    local gray="0;37m"
    local white="$close"

    local text="$1"
    local color="$close"

    if [ "$#" -eq 2 ]; then
        text="$2"
        case "$1" in
            black | white | red | green | yellow | blue | purple | cyan | gray)
                eval color="\$$1"
                ;;
        esac
    fi

    printf "${open}${color}${text}${close}"
}


function logging() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <fmt> <msg>"
        echo "Formatting Options"
        echo "  TITLE, ERROR, WARN, INFO, SUCCESS"
        return 1
    fi

    local color=
    local text="$2"

    case "$1" in
        TITLE)
            color=yellow
            ;;
        ERROR | WARN)
            color=red
            ;;
        INFO)
            color=blue
            ;;
        SUCCESS)
            color=green
            ;;
        *)
            text="$1"
    esac

    function timestamp() {
        ink gray "["
        ink purple "$(date +%H:%M:%S)"
        ink gray "] "
    }

    timestamp; ink "$color" "$text"; echo
}

function log_pass() {
    logging SUCCESS "$1"
}

function log_fail() {
    logging ERROR "$1" 1>&2
}

function log_warn() {
    logging WARN "$1" 1>&2
}

function log_info() {
    logging INFO "$1"
}

function log_echo() {
    logging TITLE "$1"
}

function download_dotfiles() {
    if [ -d "$DOTPATH" ]; then
        log_fail "$DOTPATH: already exists"
        exit 1
    fi

    e_newline
    e_header "Downloading dotfiles..."

    if is_debug; then
        :
    else
        if has "git"; then
            git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
        else
            log_fail "git requried"
            exit 1
        fi
    fi
    e_newline && e_done "Download"
}

function deploy_dotfiles() {
    e_newline
    e_header "Deploying dotfiles..."

    if [ ! -d $DOTPATH ]; then
        log_fail "$DOTPATH: not found"
        exit 1
    fi

    cd "$DOTPATH"

    if is_debug; then
        :
    else
        make deploy
    fi && e_newline && e_done "Deploy"
}

function initialize_dotfiles() {
    e_newline
    e_header "Initializing dotfile..."

    if is_debug; then
        :
    else
        e_warning $(PWD)
        if [ -f Makefile ]; then
            make init
        else
            log_fail "Makefile: not found"
            exit 1
        fi
    fi && e_newline && e_done "Initialize"
}

function install_dotfiles() {
    download_dotfiles &&
    deploy_dotfiles &&
    initialize_dotfiles "$@"
}

if echo "$-" | grep -q "i"; then
    # interactive shell でなければ終了
    VITALIZED=1
    export VITALIZED

    : return
else
    if [ "$0" = "${BASH_SOURCE:-}" ]; then
        exit
    fi

    # 既に $DOTPATH がダウンロードされているなら、インストール処理をスキップする
    if [ -d "$DOTPATH" ]; then
        return
    fi

    if [ -n "${BASH_EXECUTION_STRING:-}" ] || [ -p /dev/stdin ]; then
        # 既に VITALIZE されているなら、インストール処理をスキップする
        if [ "${VITALIZED:=0}" = 1 ]; then
            exit
        fi

        trap "e_newline && e_error 'terminated'; exit 1" INT ERR
        echo "$dotfiles_logo"
        install_dotfiles "$@"

        e_newline
        e_arrow "Restarting your shell..."
        exec "${SHELL:-/bin/zsh}"
    fi
fi
