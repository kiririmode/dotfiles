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
 ; When non-`nil', save last state of `helm-follow-mode' for the next emacs sessions.
 helm-follow-mode-persistent t
 ; Your preferred sources to find files.
 helm-for-files-preferred-list '(
                                 helm-source-buffers-list
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

(global-set-key (kbd "C-x c /") 'helm-find)
(global-set-key (kbd "C-x c g") 'helm-do-grep)
(global-set-key (kbd "C-x c o") 'helm-occur)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
(global-set-key (kbd "C-x c C-i") 'helm-lisp-completion-at-point)

(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
