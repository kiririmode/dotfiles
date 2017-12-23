(require 'yaml-mode)

(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

(with-eval-after-load "yaml-mode"
  (define-key yaml-mode-map (kbd "C-m") 'newline-and-indent))
