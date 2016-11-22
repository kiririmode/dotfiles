(eval-after-load "go-mode"
  '(progn
     (add-to-list 'load-path (expand-file-name "~/src/github.com/golang/lint/misc/emacs"))
     (add-to-list 'exec-path (expand-file-name "~/bin"))

     ; The 'gofmt' command.
     (defvar gofmt-command "goimports")
     ; Add this to .emacs to run gofmt on the current buffer when saving:
     (add-hook 'before-save-hook 'gofmt-before-save)

     (require 'golint)
     (require 'go-autocomplete)
     (ac-config-default)
     (require 'go-eldoc)
     (add-hook 'go-mode-hook 'go-eldoc-setup)

     ; Set up eldoc function and enable eldoc-mode.
     (go-eldoc-setup)
     ; Minor mode for on-the-fly syntax checking.
     (flycheck-mode 1)

     ; http://syohex.hatenablog.com/entry/20130618/1371567527
     (defvar my/helm-go-source
       '((name . "Helm Go")
         (candidates . go-packages)
         (action . (("Show document" . godoc)
                    ("Import package" . my/helm-go-import-add)))))

     (defun my/helm-go-import-add (candidate)
       (dolist (package (helm-marked-candidates))
         (go-import-add current-prefix-arg package)))

     (defun my/helm-go ()
       (interactive)
       (helm :sources '(my/helm-go-source) :buffer "*helm go*"))

     ; Jump to the definition of the expression at POINT.
     (define-key go-mode-map (kbd "M-.") 'godef-jump-other-window)
     ; Show Go documentation for the identifier at POINT.
     (define-key go-mode-map (kbd "C-.") 'godoc-at-point)

     (define-key go-mode-map (kbd "C-c C-d") 'my/helm-go)))
