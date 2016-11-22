(require 'helm-config)
(require 'helm-ls-git)

; All functions in Emacs that use `completing-read'
; or `read-file-name' and friends will use helm interface
; when this mode is turned on.
(helm-mode 1)

(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line` in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

(setq
 ; Cycle to the beginning or end of the list after reaching the bottom or top.
 helm-move-to-line-cycle-in-source t
 ; Use `recentf-list' instead of `file-name-history' in `helm-find-files'.
 helm-ff-file-name-history-use-recentf t
 ; Maximum number of items of the recent list that will be saved.
 recentf-max-saved-items 500
 ; Enable fuzzy matching in emacs-lisp completion when non-nil.
 helm-lisp-fuzzy-completion t
 ; When non-`nil', `helm-delete-minibuffer-contents' delete region from `point'.
 helm-delete-minibuffer-contents-from-point t
 ; Enable fuzzy matching in `helm-source-ls-git-status' and `helm-source-ls-git'."
 helm-ls-git-fuzzy-match t
 ; When non-`nil', save last state of `helm-follow-mode' for the next emacs sessions.
 helm-follow-mode-persistent t
 ; Your preferred sources to find files.
 helm-for-files-preferred-list '(
                                 helm-source-buffers-list
                                 helm-source-ls-git
                                 helm-source-recentf
                                 helm-source-file-cache
                                 helm-source-files-in-current-dir))

; It is `helm' replacement of regular `M-x' `execute-extended-command'.
(global-set-key (kbd "M-x") 'helm-M-x)
; It is drop-in replacement of `yank-pop'.
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
; Preconfigured `helm' for helm implementation of `find-file'.
(global-set-key (kbd "C-x C-f") 'helm-find-files)
; Preconfigured `helm' to list buffers.
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
; Preconfigured `helm' for `recentf'.
(global-set-key (kbd "C-x C-r") 'helm-recentf)
; Preconfigured `helm' for opening files.
(global-set-key (kbd "C-x b") 'helm-for-files)
; Preconfigured `helm' for Man and Woman pages.
(global-set-key (kbd "C-x m") 'helm-man-woman)

; Browse files and see status of project with its vcs.
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "C-x C-g") 'helm-ls-git-ls)

(global-set-key (kbd "C-x c /") 'helm-find)
(global-set-key (kbd "C-x c g") 'helm-do-grep)
(global-set-key (kbd "C-x c o") 'helm-occur)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
(global-set-key (kbd "C-x c C-i") 'helm-lisp-completion-at-point)

(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)


;; help-swoop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm-swoop)

;; Save buffer when helm-multi-swoop-edit complete
(setq
 ; Save each buffer you edit when editing is complete
 helm-multi-swoop-edit-save t
 ; Split window when having multiple windows open
 helm-swoop-split-with-multiple-windows t
 ; Split direction
 helm-swoop-split-direction 'split-window-vertically
 ; If nil, you can slightly boost invoke speed in exchange for text colorIf nil, you can slightly boost invoke speed in exchange for text color
 helm-swoop-speed-or-color t
 ; Return to the opposite side of line
 helm-swoop-move-to-line-cycle t
)

; List the all lines to another buffer, which is able to squeeze by
; any words you input.
(global-set-key (kbd "M-i") 'helm-swoop)
; Go back to last position where `helm-swoop' was called
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; help-ag
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm-ag)

(setq
 ; Insert thing at point as search pattern.
 helm-ag-insert-at-point 'symbol
 ; Enable fuzzy match
 helm-ag-fuzzy-match t)

;; helm-descbinds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm-descbinds)

; Use `helm' for `describe-bindings'.
(helm-descbinds-mode)

(global-set-key (kbd "C-c b") 'helm-descbinds)
