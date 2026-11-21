#!/usr/bin/env zsh
#
# .zshrc - インタラクティブシェル設定ファイル
#
# このファイルはインタラクティブシェル（ターミナルで直接操作するシェル）でのみ読み込まれる。
# キーバインド、エイリアス、プロンプト、補完設定などを行う。
#
# 読み込み順序: .zshenv → .zprofile → .zshrc → .zlogin
#

# ==============================================================================
# セキュリティ・基本設定
# ==============================================================================

# ファイル作成時のデフォルトパーミッション
# 022 = owner以外の書き込み権限を除去（ファイル: 644, ディレクトリ: 755）
umask 022

# コアダンプを無効化（セキュリティとディスク容量の観点から）
limit coredumpsize 0

# ==============================================================================
# キーバインド設定
# ==============================================================================

# 既存のキーマップをリセットしてクリーンな状態から開始
bindkey -d

# Emacsキーバインドを使用（Ctrl-A: 行頭、Ctrl-E: 行末、Ctrl-R: 履歴検索等）
# viモードを使用したい場合は bindkey -v に変更
bindkey -e

# ==============================================================================
# 基本設定ファイルの読み込み
# ==============================================================================

# dotfilesのパス設定を読み込み（$DOTPATH環境変数を設定）
if [[ -f "$HOME/.path" ]]; then
    source "$HOME/.path"
fi

# 共通ユーティリティ関数を読み込み（get_os, logging等）
export VITAL_PATH="$DOTPATH/etc/lib/vital.sh"
if [[ -f "$VITAL_PATH" ]]; then
    source "$VITAL_PATH"
fi

# ==============================================================================
# mise 本体を PATH に入れる
# ==============================================================================
# .zsh.d/mise.zsh は、`has mise` が真のときだけ `mise activate zsh` を実行する。
# ところが、この時点の PATH には mise 本体の置き場所が無いことがある。
#   - Linux: README の手順（mise.run）で入れた mise は ~/.local/bin にある。
#     ~/.local/bin を PATH に足すのは、このファイル末尾の PATH 設定である。
#   - macOS: Homebrew の mise は /opt/homebrew/bin（Intel では /usr/local/bin）にある。
#     /opt/homebrew/bin を足すのは /etc/zprofile の path_helper だけである。
#     このため、ログインしない対話シェル（zsh -ic）では PATH に無い。
# そこで .zsh.d を読む前に、これらのディレクトリを PATH の末尾に足す。
# 末尾に足すのは、既にある要素の順序を変えないためである。
# .zshenv の typeset -U により、既にある要素は元の位置に残る。
# 最終的な優先順位は、このファイル末尾の PATH 設定が決める。
path+=(
    "$HOME/.local/bin"(N-/)     # mise.run の導入先
    /opt/homebrew/bin(N-/)      # Homebrew（Apple Silicon）
    /usr/local/bin(N-/)         # Homebrew（Intel）
)

# ==============================================================================
# 機能別設定ファイルの読み込み
# ==============================================================================

# .zsh.d/配下の設定ファイルを読み込み
# 含まれるファイル: alias.zsh, setopt.zsh, 言語環境設定等
# (N): Null Glob - マッチするファイルがなくてもエラーにならない
for conf in "$HOME"/.zsh.d/*.zsh(N); do
    source "$conf"
done

# ==============================================================================
# OS固有の設定読み込み
# ==============================================================================

# macOS: osx.zshrc, Linux: linux.zshrc 等
# -r: ファイルが存在し、読み取り可能かチェック
if [[ -r "$HOME/.zsh.d/$(get_os).zshrc" ]]; then
    source "$HOME/.zsh.d/$(get_os).zshrc"
fi

# ==============================================================================
# ユーティリティ関数
# ==============================================================================

# pe: ack + peco によるインタラクティブファイル検索
# 使用方法: pe <検索パターン>
# 検索結果をpecoで絞り込み、選択したファイルをlessで表示
if (( $+commands[ack] )) && (( $+commands[peco] )); then
    function pe() {
        ack "$@" . | peco --exec 'awk -F : '"'"'{print "+" $2 " " $1}'"'"' | xargs less -N '
    }
fi

# ==============================================================================
# 外部ツールの初期化
# ==============================================================================

# --- direnv ---
# ディレクトリ移動時に.envrcを自動読み込み（プロジェクト別の環境変数管理）
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

# --- bash補完の互換性 ---
# bash用の補完スクリプトをzshで使用可能にする
autoload -U +X bashcompinit && bashcompinit

# --- Terraform ---
# Terraform CLIのタブ補完を有効化
if (( $+commands[terraform] )); then
    complete -o nospace -C "$(command -v terraform)" terraform
fi

# --- Starship ---
# 高速でカスタマイズ可能なクロスシェルプロンプト
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# ==============================================================================
# ターミナル統合
# ==============================================================================

# iTerm2シェル統合（macOS）
# コマンド履歴ナビゲーション、出力キャプチャ等の機能を提供
if [[ -e "$HOME/.iterm2_shell_integration.zsh" ]]; then
    source "$HOME/.iterm2_shell_integration.zsh"
fi

# bun completions
[ -s "/Users/kiririmode/.bun/_bun" ] && source "/Users/kiririmode/.bun/_bun"

# ==============================================================================
# PATH 設定
# ==============================================================================

# path 配列の重複エントリを自動除去（$PATH と path 配列は連動している）
typeset -U path

export BUN_INSTALL="$HOME/.bun"

# 優先度の高い順に先頭へ追加
path=(
    "$HOME/.local/bin"
    "$BUN_INSTALL/bin"
    $path
)

alias claude-mem='/Users/kiririmode/.bun/bin/bun "/Users/kiririmode/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
