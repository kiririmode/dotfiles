#!/bin/bash
#
# Claude Code のインストールとプラグイン設定
#

set -euo pipefail

MARKETPLACE_URL="https://github.com/kiririmode/claude-plugins"
MARKETPLACE_NAME="kiririmode-claudecode-plugins"

PLUGINS=(
    "common-dev-essentials"
    "general"
    "github-dev-essentials"
)

# Claude Code のインストール
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# マーケットプレイスの追加
echo "Adding marketplace: ${MARKETPLACE_URL}"
claude plugin marketplace add "${MARKETPLACE_URL}"

# プラグインのインストール
for plugin in "${PLUGINS[@]}"; do
    echo "Installing plugin: ${plugin}@${MARKETPLACE_NAME}"
    claude plugin install "${plugin}@${MARKETPLACE_NAME}"
done

echo "Claude Code setup complete!"
