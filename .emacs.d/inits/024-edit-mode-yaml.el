(require 'yaml-mode)

(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

(eval-after-load "yaml-mode"
  '(progn
     (define-key yaml-mode-map (kbd "C-m") 'newline-and-indent)))
