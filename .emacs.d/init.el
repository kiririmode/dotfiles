(package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;; El-get Basic Setup
;;;
;;;
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

; Configuration files are located in ~/.emacs.d/inits
(setq el-get-user-package-directory (locate-user-emacs-file "inits"))

; install packages
(el-get-bundle anzu
  (global-set-key (kbd "M-%") 'anzu-query-replace)) ; anzu version of `query-replace'.
(el-get-bundle auto-complete)
(el-get-bundle auto-highlight-symbol)
(el-get-bundle atom-dark-theme)
(el-get-bundle dockerfile-mode)
(el-get-bundle edit-server)
(el-get-bundle exec-path-from-shell)
(el-get-bundle expand-region)
(el-get-bundle flycheck)
(el-get-bundle gitconfig-mode)
(el-get-bundle gitignore-mode)
(el-get-bundle git-gutter)
(el-get-bundle golint)
(el-get-bundle go-autocomplete)
(el-get-bundle go-eldoc)
(el-get-bundle go-mode)
(el-get-bundle helm)
(el-get-bundle helm-ag)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-ls-git)
(el-get-bundle helm-perldoc)
(el-get-bundle helm-swoop)
(el-get-bundle init-loader)
(el-get-bundle helm-git-grep)
(el-get-bundle graphviz-dot-mode)
(el-get-bundle markdown-mode)
(el-get-bundle magit)
(el-get-bundle multiple-cursors)
(el-get-bundle powerline)
(el-get-bundle popwin)
(el-get-bundle syohex/emacs-import-popwin :name import-popwin)
(el-get-bundle prodigy)
(el-get-bundle redo+)
(el-get-bundle ddskk)
(el-get-bundle use-package)
(el-get-bundle terraform-mode)
(el-get-bundle wgrep)
(el-get-bundle web-mode)
(el-get-bundle yaml-mode)
(el-get-bundle yasnippet)
(el-get-bundle init-loader)


;;
;; 00X: global configuration with emacs default packages.
;; 01X: global configuration with cask-installed packages.
;; 02X: edit mode
(setq
 ; Show loading log message if this value is t. If this value is `error-only',
 ; log message is shown only errors occured.
 init-loader-show-log-after-init "error-only"
 ; Byte-compile configuration files if this value is non-nil.
 init-loader-byte-compile nil)

; Load configuration files in INIT-DIR.
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (golint gitignore-mode gitconfig-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
