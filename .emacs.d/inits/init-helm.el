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
