DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .devcontainer .config
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all: install

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

# Create a symbolic links of dotfiles to your home directory.
deploy: deploy-config
	@echo '===> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

# Create symbolic links for .config subdirectories individually
# This avoids overwriting existing ~/.config directory
CONFIG_ITEMS := ghostty git karabiner mise peco starship.toml
deploy-config:
	@echo '===> Deploying .config items...'
	@mkdir -p $(HOME)/.config
	@$(foreach val, $(CONFIG_ITEMS), ln -sfnv $(DOTPATH)/.config/$(val) $(HOME)/.config/$(val);)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

# Initialize development environment
init: brew brew-bundle fonts zplug tmux defaults

brew:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/brew.sh

brew-bundle:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/brew-bundle.sh

fonts:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/fonts.sh

zplug:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/zplug.sh

tmux:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/tmux.sh

defaults:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/defaults.sh

mise-setup:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/mise.sh

go-tools:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/go-tools.sh

install: update deploy init mise-setup go-tools
	@exec $$SHELL

clean:
	@echo 'Remove dotfiles in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

.PHONY: all list deploy deploy-config update init brew brew-bundle fonts zplug tmux defaults mise-setup go-tools install clean
