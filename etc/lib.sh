#!/bin/bash

if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles
    export DOTPATH
fi

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

# shellcheck disable=SC2120  # 引数なし（標準入力）でも呼ぶ
lower() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" ] && [ -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

function ostype() {
    # shellcheck disable=SC2119  # 標準入力を小文字化する用途
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

# 環境変数の先頭にパスを追加（ディレクトリが存在する場合のみ）
# Usage: prepend VAR_NAME /path/to/add
function prepend() {
    local var=$1
    local value=$2
    if [[ -d "$value" ]]; then
        eval "$var=\"$value:\${$var}\""
    fi
}

function has() {
    which "$1" > /dev/null 2>&1
    return $?
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
    die "${1:-${FUNCNAME[0]}}"
}

# shellcheck disable=SC2034  # 色の変数は eval で名前から参照する
function ink() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
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

    printf '%b' "${open}${color}${text}${close}"
}


function logging() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
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
