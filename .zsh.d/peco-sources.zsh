# -*- mode: shell-script -*-
#
# peco を使ったインタラクティブ検索・選択機能
#
# 依存ツール: peco, ghq, git, z
#

# ------------------------------------------------------------------------------
# ghq で管理しているリポジトリを peco で選択して移動する
# キーバインド: Ctrl-X Ctrl-Z
# ------------------------------------------------------------------------------
function peco-ghq-src() {
    local selected_dir
    selected_dir=$(ghq list --full-path | peco)
    if [[ -n "${selected_dir}" ]]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq-src
bindkey '^X^Z' peco-ghq-src

# ------------------------------------------------------------------------------
# git ブランチを peco で選択してコマンドラインに挿入する
# ローカル・リモートブランチ両方が対象
# キーバインド: Ctrl-X Ctrl-B
# ------------------------------------------------------------------------------
function peco-git-branches() {
    local res
    # --no-color: ANSIエスケープシーケンスを除去
    # sed: 現在のブランチを示す * マークをスペースに置換
    # awk: ブランチ名のみを抽出
    res=$(git branch -a --no-color 2>/dev/null | sed 's/^\*/ /' | awk '{ print $1 }' | peco)
    if [[ -n "${res}" ]]; then
        BUFFER+="${res}"
    fi
    zle clear-screen
}
zle -N peco-git-branches
bindkey '^X^B' peco-git-branches

# ------------------------------------------------------------------------------
# git 管理下のファイルを peco で選択してコマンドラインに挿入する
# キーバインド: Ctrl-X Ctrl-F
# ------------------------------------------------------------------------------
function peco-git-files() {
    local res
    res=$(git ls-files 2>/dev/null | peco)
    if [[ -n "${res}" ]]; then
        BUFFER+="${res}"
    fi
    zle clear-screen
}
zle -N peco-git-files
bindkey '^X^F' peco-git-files

# ------------------------------------------------------------------------------
# コマンド履歴を peco で検索・選択する
# 現在のコマンドライン入力をクエリとして使用
# キーバインド: Ctrl-R
# ------------------------------------------------------------------------------
function peco-select-history() {
    # tac コマンドが無い環境では tail -r で代用（macOS等）
    local tac_cmd
    tac_cmd=${commands[tac]:-"tail -r"}

    local selected
    selected=$(history -n 1 | eval "${tac_cmd}" | peco --query "${LBUFFER}")
    if [[ -n "${selected}" ]]; then
        BUFFER="${selected}"
        CURSOR=${#BUFFER}
    fi
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# ------------------------------------------------------------------------------
# z コマンドの履歴から peco でディレクトリを選択して移動する
# z: 頻繁に使用するディレクトリへのジャンプツール
# キーバインド: Ctrl-X Ctrl-V
# ------------------------------------------------------------------------------
function peco-z-search() {
    # z -l: 履歴一覧を表示
    # sort -rn: スコア順（降順）でソート
    # cut -c 12-: スコア部分を除去してパスのみ取得
    local res
    res=$(z -l 2>&1 | sort -rn | cut -c 12- | peco)
    if [[ -n "${res}" ]]; then
        BUFFER="cd ${res}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-z-search
bindkey '^X^V' peco-z-search
