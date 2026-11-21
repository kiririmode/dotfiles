# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

macOS/Linux向けの個人用dotfiles管理リポジトリ。zsh設定、開発環境セットアップスクリプト、各種ツール設定を管理。

## よく使うコマンド

セットアップは `mise bootstrap` で行う（Makefile と `etc/scripts/` は廃止済み）。初回の手順は README.md を参照。

```bash
# 変更内容の確認（何も変更しない）
mise bootstrap --dry-run

# リポジトリを fast-forward してから全体を適用
mise bootstrap --update

# dotfiles の symlink だけを適用 / 状態確認 / 削除
mise dot apply
mise dot status
mise dot unapply

# blogsync の設定ファイルをテンプレートから生成
BLOGSYNC_PASSWORD=... mise run blogsync-config
```

## アーキテクチャ

### コア構造

- `.path` - `$DOTPATH`環境変数を設定するスクリプト。シンボリックリンクを解決してdotfilesの実際のパスを取得
- `etc/lib.sh` - 共通ユーティリティ関数（OS検出、ロギング）。`.zshenv` が読み込む
- `.config/mise/conf.d/` - `mise bootstrap` の定義。`~/.config/mise` はこのリポジトリの `.config/mise` への symlink なので、グローバル設定として読まれる

### zsh設定の読み込み順序

1. `.zshenv` - 環境変数設定（PATH、エディタ、言語設定等）
2. `.zshrc` - インタラクティブシェル設定
3. `.zsh.d/*.zsh` - 機能別設定ファイル（alias、言語環境等）
4. `.zsh.d/$(get_os).zshrc` - OS固有設定（osx.zshrc等）

### セットアップ（mise bootstrap）

`.config/mise/conf.d/` 配下：
- `dotfiles.toml` - `$HOME` からリポジトリへの symlink（`[dotfiles]`）。`dotfiles.root` は `~/.config/mise` の実パスから求めたリポジトリのルート
- `packages.toml` - OS パッケージ。macOS は Homebrew・cask・Mac App Store、Linux（WSL2 の Ubuntu）は apt と aqua backend の `[tools]`。各エントリは `os` で対象 OS を絞る
- `bootstrap.toml` - Git リポジトリ（zplug、tpm）、macOS の defaults、`bootstrap` タスク（Claude Code の導入など）、`blogsync-config` タスク

`.config/mise/config.toml` 自体は言語ランタイムの `[tools]` と `[settings]` だけを持つ。

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

`mise bootstrap` 側の OS 分岐は、`get_os` ではなく各エントリの `os`（`macos` / `linux`）で表す。WSL は `linux` として扱う。
