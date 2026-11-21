#!/bin/sh
# ax の版が .apm/apm.yml（スキル）と packages.toml（CLI）で一致しているかを確かめる。
# スキルの説明と CLI のフラグを揃えるため、両者は同じ版でなければならない。
# pre-commit の local フック（ax-version-sync）から、リポジトリのルートで呼ばれる。
set -eu

apm_file=.apm/apm.yml
mise_file=.config/mise/conf.d/packages.toml

# $1: ファイル, $2: 抽出用の sed 式（版を \1 に取る）。該当行がちょうど1行でなければ失敗する。
extract() {
  matches=$(sed -nE "$2" "$1")
  count=$(printf '%s' "$matches" | grep -c '' || true)
  if [ "$count" -ne 1 ]; then
    echo "error: $1 で ax の版を含む行が ${count} 件見つかった（1 件であるべき）" >&2
    return 1
  fi
  printf '%s\n' "$matches"
}

# 例: "    - yusukebe/ax#v0.1.25"。タグの無い依存は版を固定していないので失敗させる。
apm_version=$(extract "$apm_file" 's/^[[:space:]]*-[[:space:]]*yusukebe\/ax#v?([^[:space:]#]+).*$/\1/p')
# 例: "\"github:yusukebe/ax\" = \"0.1.25\""。行頭に限るので、コメント中の記述には一致しない。
mise_version=$(extract "$mise_file" 's/^"github:yusukebe\/ax"[[:space:]]*=[[:space:]]*"v?([^"]+)".*$/\1/p')

if [ "$apm_version" != "$mise_version" ]; then
  echo "error: ax の版がずれている" >&2
  echo "  $apm_file: $apm_version" >&2
  echo "  $mise_file: $mise_version" >&2
  exit 1
fi
