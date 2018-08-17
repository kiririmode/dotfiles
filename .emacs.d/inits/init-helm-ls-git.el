(global-set-key (kbd "C-x C-g") 'helm-ls-git-ls)

 ; Enable fuzzy matching in `helm-source-ls-git-status' and `helm-source-ls-git'."
(setq  helm-ls-git-fuzzy-match t)

(add-to-list 'helm-for-files-preferred-list 'helm-source-ls-git)
