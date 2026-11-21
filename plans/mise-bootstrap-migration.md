# この Mac を mise bootstrap へ移行する手順

ブランチ `feat/mise-bootstrap` の構成を、いま使っている Mac に適用するための手順である。
新しいマシンの手順は README.md にある。この文書は既存の Mac に固有の問題だけを扱う。

## 現状の問題

`~/.config` は、旧クローン `~/dotfiles/.config` への symlink である。
旧 Makefile の `deploy-config` は `~/.config/<name>` に symlink を張っていた。
しかし `~/.config` 自体が旧クローンを指しているため、リンクは旧クローンの作業ツリーの中に作られた。
さらに、`git`、`peco`、`karabiner` は旧クローン側で実ディレクトリになっている。
`ln -sfn` は既存のディレクトリを置き換えず、その中にリンクを作る。
そのため、この3つにはリポジトリの設定が反映されていない。

`mise bootstrap --dry-run` はこの3つで止まる（`refusing to overwrite existing files`）。

旧クローン側にしか無いファイルもある。

- `~/dotfiles/.config/git/ignore`: いま効いているグローバル gitignore である。リポジトリには無い。
- `~/dotfiles/.config/karabiner/karabiner.json`: リポジトリ版と内容が異なる。Karabiner-Elements が実際に書き込んでいるのは旧クローン側である。
- `~/dotfiles/.config/{ccstatusline,gh,herdr,qmd}`: dotfiles で管理していない設定である。`gh/hosts.yml` は認証情報を含む。

## 手順

### 1. 旧クローン側にしか無い設定をリポジトリへ取り込む

```bash
cd ~/src/github.com/kiririmode/dotfiles

# グローバル gitignore。中身を確かめてから取り込む
cat ~/dotfiles/.config/git/ignore
cp ~/dotfiles/.config/git/ignore .config/git/ignore

# karabiner.json。差分を見て、どちらを正とするか決める
diff ~/dotfiles/.config/karabiner/karabiner.json .config/karabiner/karabiner.json
# 旧クローン側を正とする場合
cp ~/dotfiles/.config/karabiner/karabiner.json .config/karabiner/karabiner.json

# 取り込んだ設定をコミットする。コミットしないと、WSL や新しいマシンには届かない
git add .config/git/ignore .config/karabiner/karabiner.json
git commit -m "chore: 旧クローンにしか無かった git ignore と karabiner 設定を取り込む"
```

### 2. ~/.config を実ディレクトリに作り直す

herdr はソケットを `~/.config/herdr` に置いている。先に herdr を止めておく。

```bash
mkdir ~/.config.new
cp -a ~/dotfiles/.config/{ccstatusline,gh,herdr,qmd} ~/.config.new/
rm -f ~/.config.new/herdr/*.sock*

rm ~/.config                 # symlink だけを消す。旧クローンの中身は残る
mv ~/.config.new ~/.config
ln -s ~/src/github.com/kiririmode/dotfiles/.config/mise ~/.config/mise
```

`--config-dir` を使わずに `~/.config/mise` の symlink を手で作る。
この場合、`mise bootstrap --update` がこのリンクを辿ってリポジトリを fast-forward するかは確かめていない。
効かないときは、リポジトリで `git pull` を手で実行する。

### 3. 適用する

```bash
mise bootstrap --dry-run     # dotfiles の衝突が消えたことを確かめる
mise bootstrap
killall Finder SystemUIServer
```

`dotfiles` の段階で `~/.config/{git,peco,karabiner,ghostty,starship.toml,blogsync}` が symlink として作られる。
`tools` の段階では、mise が blogsync 0.20.1 を入れる。
`~/bin/blogsync` が PATH の先にあれば、そちらが優先される。

### 4. 確かめる

```bash
mise dot status              # すべて up to date
mise bootstrap plan --detailed-exitcode; echo $?   # 0 なら差分なし
git config --global --get core.excludesfile || git check-ignore -v <無視されるはずのファイル>
```

## 戻し方

旧クローンの `~/dotfiles/.config` は手順2で変更しない。そのため、次のコマンドで元の状態に戻せる。

```bash
mv ~/.config ~/.config.migrated
ln -s ~/dotfiles/.config ~/.config
```

## 移行しなかった symlink

旧 Makefile は `.??*` に一致するファイルをすべてホームに張っていた。
次のものは、ホームに置く理由が確認できなかったので `[dotfiles]` に入れていない。
既存のリンクは消していない。不要なら手で消す。

| リンク | 理由 |
| --- | --- |
| `~/.envrc`、`~/.env`、`~/.env.example` | ホームで direnv が API キーを読む構成になっている。`.env` は Git 管理外なので、新しいマシンでは元ファイルが無い |
| `~/.gitignore`、`~/.gitattributes` | `.gitconfig` が参照していない。git が読むのは `~/.config/git/` 側である |
| `~/.pre-commit-config.yaml`、`~/.serena` | リポジトリ用の設定である |
| `~/bin` | 中身は `bin/blogsync` だけで、Git 管理外である。blogsync は mise の `[tools]` に移した |
| `~/.claude/.claude` | `~/.claude` が実ディレクトリのため、`ln -sfn` が中に作った誤ったリンクである |
