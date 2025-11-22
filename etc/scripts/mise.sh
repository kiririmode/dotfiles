#!/bin/bash
#
# mise による各言語ランタイムのセットアップ
#

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib.sh

# mise がインストールされているか確認、なければインストール
if ! command -v mise &> /dev/null; then
    e_header "Installing mise..."
    curl https://mise.run | sh

    # PATH に追加（現在のセッション用）
    export PATH="$HOME/.local/bin:$PATH"

    if ! command -v mise &> /dev/null; then
        e_error "Failed to install mise"
        exit 1
    fi
    log_pass "mise installed successfully"
fi

# mise の信頼設定（グローバル設定を信頼）
mise trust --all 2>/dev/null || true

# グローバル設定からツールをインストール
e_newline
e_header "Installing runtimes via mise..."

mise install

e_done "mise setup completed"
