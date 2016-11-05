DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all: install

help:
	@echo "make list         #=> Show dot files in this repo"
	@echo "make deploy       #=> Create symlink to home directory"
	@echo "make init         #=> Setup environment settings"
	@echo "make update       #=> Fetch changes for this repo"
	@echo "make install      #=> Run make update, deploy, init"
	@echo "make clean        #=> Remove the dotfiles and this repo"

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

# Create a symbolic links of dotfiles to your home directory.
deploy:
	@echo 'Copyright (c) 2017 kiririmode All Rights Reserved.'
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

install: update deploy init
	@exec $$SHELL

clean:
	@echo "Remove dotfiles in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $HOME/$(val);)
	-rm -rf $(DOTPATH)
