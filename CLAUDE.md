# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

macOS/Linux向けの個人用dotfiles管理リポジトリ。zsh設定、開発環境セットアップスクリプト、各種ツール設定を管理。

## よく使うコマンド

```bash
# 初回インストール（dotfilesのクローン後）
make

# dotfilesの更新（git pull + submodule更新）
make update

# dotfilesをホームディレクトリにシンボリックリンク
make deploy

# 開発環境の初期化スクリプト実行
make init

# 言語ランタイムのセットアップ（mise使用）
make mise-setup

# Goツールのインストール
make go-tools

# dotfilesの削除
make clean
```

## アーキテクチャ

### コア構造

- `.path` - `$DOTPATH`環境変数を設定するスクリプト。シンボリックリンクを解決してdotfilesの実際のパスを取得
- `etc/lib.sh` - 共通ユーティリティ関数（OS検出、ロギング、dotfilesインストール処理）
- `Makefile` - dotfilesのデプロイ・初期化を管理するメインエントリーポイント

### zsh設定の読み込み順序

1. `.zshenv` - 環境変数設定（PATH、エディタ、言語設定等）
2. `.zshrc` - インタラクティブシェル設定
3. `.zsh.d/*.zsh` - 機能別設定ファイル（alias、言語環境等）
4. `.zsh.d/$(get_os).zshrc` - OS固有設定（osx.zshrc等）

### 初期化スクリプト

`etc/scripts/` 配下：
- `brew.sh` - Homebrewインストール（macOS）
- `brew-bundle.sh` - Brewfileによるパッケージインストール（macOS）
- `mise.sh` - miseによる各言語ランタイム環境構築
- `go-tools.sh` - Goツールのインストール
- `tmux.sh` - Tmux Plugin Managerのインストール
- `fonts.sh` - フォントインストール（macOS）
- `zplug.sh` - zplugインストール
- `defaults.sh` - macOSシステム設定

Brewfile: `etc/Brewfile`

### 設定ファイル

- `.config/karabiner/` - Karabiner-Elements設定（macOSキーリマップ）
- `.config/starship.toml` - Starshipプロンプト設定
- `.config/peco/` - pecoファジーファインダー設定
- `.config/mise/config.toml` - mise設定（言語ランタイム管理）
- `.tmux.conf` - tmux設定
- `.gitconfig` - Git設定

### 言語環境管理

mise（ポリグロットランタイムマネージャー）で複数言語のバージョンを統一管理：
- Python, Node.js, Go, Ruby, Java など

Pythonパッケージ管理には uv を使用。

設定ファイル: `.config/mise/config.toml`

## OS固有の処理

`get_os`関数（`etc/lib.sh`）でOS判定し、以下のように分岐：
- macOS: `.zsh.d/mac.zshenv`, `.zsh.d/osx.zshrc`
- Linux: `.zsh.d/linux.zshrc`（存在する場合）

各スクリプトは`is_osx`/`is_linux`関数で条件分岐し、対象OSでのみ実行される。
