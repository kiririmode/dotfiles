(require 'git-gutter)
(require 'magit)
(require 'gitconfig-mode)
(require 'gitignore-mode)

(setq
 ; List of version control backends for which `git-gutter.el` will be used.
 git-gutter:handled-backends '(git svn hg bzr)
 ; Time interval in seconds for updating diff information.
 git-gutter:update-interval 1
 ; Minor mode lighter in mode-line
 git-gutter:lighter " GG"
 ; Option of 'git diff'
 git-gutter:diff-option "-w")

; Non-nil if Global-Git-Gutter mode is enabled.
(global-git-gutter-mode +1)
; Setup for linum-mode.
(git-gutter:linum-setup)

(git-gutter:start-update-timer)

;;; git-gutter

; Show diff information in gutter
(global-set-key (kbd "C-c C-g") 'git-gutter)
; Popup current diff hunk.
(global-set-key (kbd "C-c v =") 'git-gutter:popup-hunk)
; Stage this hunk like 'git add -p'.
(global-set-key (kbd "C-c v s") 'git-gutter:stage-hunk)
; Revert current hunk.
(global-set-key (kbd "C-c v r") 'git-gutter:revert-hunk)
; Move to previous diff hunk
(global-set-key (kbd "C-c v p") 'git-gutter:previous-hunk)
; Move to next diff hunk
(global-set-key (kbd "C-c v n") 'git-gutter:next-hunk)

;;; magit

; Show the status of the current Git repository in a buffer.
(global-set-key (kbd "C-x v") 'magit-status)
