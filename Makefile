DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all: install

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

# Create a symbolic links of dotfiles to your home directory.
deploy:
	@echo '===> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

init:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

node-setup:
	$(DOTPATH)/etc/init/scripts/setup-node.sh

go-setup:
	$(DOTPATH)/etc/init/scripts/setup-go.sh

install: update deploy init
	@exec $$SHELL

clean:
	@echo "Remove dotfiles in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $HOME/$(val);)
	-rm -rf $(DOTPATH)
