# dotfiles

This is a repository with my configuration files, that are normally located in `$HOME` directory, as known as **dotfiles**.

The setup runs on [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html) and supports macOS and Linux (Ubuntu on WSL2).

# Requirements

- mise 2026.11 or later (`mise bootstrap` and `[dotfiles]`)
- `git` and `curl`
- Linux: `sudo` (apt packages are installed through it)

# Installation

Install mise, then let `mise bootstrap` clone this repository and apply it.

```bash
# Ubuntu (WSL2) only
sudo apt-get update && sudo apt-get install -y curl git

curl https://mise.run | sh
~/.local/bin/mise bootstrap \
  --from https://github.com/kiririmode/dotfiles.git \
  --from-dir ~/src/github.com/kiririmode/dotfiles \
  --config-dir .config/mise
```

`--config-dir .config/mise` links `~/.config/mise` to `.config/mise` in the checkout.
From then on, the files there are the global mise config:

| File | Content |
| --- | --- |
| `.config/mise/config.toml` | Language runtimes (`[tools]`) and settings |
| `.config/mise/conf.d/dotfiles.toml` | Symlinks from `$HOME` into this repository (`[dotfiles]`) |
| `.config/mise/conf.d/packages.toml` | OS packages: Homebrew / Mac App Store on macOS, apt and aqua tools on Linux |
| `.config/mise/conf.d/bootstrap.toml` | Git repositories (zplug, tpm), macOS defaults, `bootstrap` task |

On Ubuntu (WSL2), the default login shell is bash. Switch it to zsh once (`chsh` asks for your password, so it is not part of `mise bootstrap`):

```bash
chsh -s "$(command -v zsh)"
```

On macOS, run `killall Finder SystemUIServer` after the first run so that the changed defaults take effect.
`mas` apps need a signed-in Apple Account; if `mas` was not installed yet, run `mise bootstrap` again.

# Usage

```bash
# Preview what would change
mise bootstrap --dry-run

# Pull this repository and apply everything again
mise bootstrap --update

# Apply only the symlinks
mise dot apply

# Show the state of the symlinks
mise dot status

# Remove the symlinks that mise created
mise dot unapply

# Generate ~/.config/blogsync/config.yaml from its template
BLOGSYNC_PASSWORD=... mise run blogsync-config
```
