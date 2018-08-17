(setq
 ; Insert thing at point as search pattern.
 helm-ag-insert-at-point 'symbol
 ; Enable fuzzy match
 helm-ag-fuzzy-match t
 ; Command line option of `ag'. This is appended after `helm-ag-base-command'
 helm-ag-command-option "--hidden")

(global-set-key (kbd "M-p") 'helm-ag-project-root)
