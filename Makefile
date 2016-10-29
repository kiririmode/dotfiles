DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

# 隠しファイル、bin に対してシンボリックリンクを張る
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
