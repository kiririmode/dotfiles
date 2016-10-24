deploy:
	@echo 'Copyright (c) 2017 kiririmode All Rights Reserved.'
	@echo '===> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
