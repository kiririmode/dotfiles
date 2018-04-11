(with-eval-after-load "go-mode"
  (add-to-list 'exec-path (expand-file-name "~/bin"))

  ; Add this to .emacs to run gofmt on the current buffer when saving:
  (add-hook 'before-save-hook 'gofmt-before-save)

   ; golint is a linter for Go source code.
  (add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/golang/lint/misc/emacs"))
  (require 'golint)
  (add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))
  (require 'go-flycheck)

  (require 'go-autocomplete)
  (ac-config-default)
  (require 'go-eldoc)
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook 'flycheck-mode)
  (add-hook 'go-mode-hook (lambda()
                            ; The 'gofmt' command.
                            (setq gofmt-command "goimports")))

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

  (define-key go-mode-map (kbd "C-c C-d") 'my/helm-go))
