#!/bin/zsh
#
# mise - ポリグロットランタイムマネージャーの初期化
#
# mise は Python, Node.js, Go, Ruby, Perl, Java などの
# 複数言語のバージョン管理を統一的に行うツール
#

if has mise; then
    # miseの有効化
    # --shims: シム方式（高速だがディレクトリ変更時の自動切り替えなし）
    # なし: hook方式（ディレクトリ変更時に自動でバージョン切り替え）
    eval "$(mise activate zsh)"

    # シェル補完の有効化
    eval "$(mise completion zsh)"

    # 便利なエイリアス
    alias mx="mise exec --"        # mise exec のショートカット
    alias mr="mise run"            # mise run のショートカット（タスクランナー）
    alias mi="mise install"        # mise install のショートカット
    alias mu="mise use"            # mise use のショートカット
    alias ml="mise list"           # mise list のショートカット
    alias mup="mise upgrade"       # mise upgrade のショートカット
fi

e_done "setting mise environment"
