;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; Edit Behavior

(setq-default
 ; Non-nil means do not display continuation lines.
 ; Instead, give each line of text just one screen line.
 truncate-lines t
 ; Indentation can insert tabs if this is non-nil.
 indent-tabs-mode nil
 ; Distance between tab stops (for display of tab characters), in columns.
 tab-width 4
)

(setq
 ; Nonzero means echo unfinished commands after this many seconds of pause.
 echo-keystrokes 0.1
 ; Non-nil means don't consider case significant in completion.
 completion-ignore-case t
 ; Non-nil means when reading a file name completion ignores case.
 read-file-name-completion-ignore-case t
 ; Non-nil means completion ignores case when reading a buffer name.
 read-buffer-completion-ignore-case t
 ; If non-nil, backups will be inhibited.
 backup-inhibited t
 ; If this variable is t, VC follows the link and visits the real file,
 ; telling you about it in the echo area.
 vc-follow-symlinks t
 ; If non-nil, M-x delete-trailing-whitespace deletes trailing lines.
 delete-trailing-lines t
 ; If non-nil, `kill-line' with no arg at start of line kills the whole line.
 kill-whole-line t
 ; If non-nil, `next-line' inserts newline to avoid `end of buffer' error.
 next-line-add-newlines nil)

; Style used when showing a matching paren.
; Valid styles are `parenthesis' (meaning show the matching paren),
; `expression' (meaning show the entire expression enclosed by the paren) and
; `mixed' (meaning show the matching paren if it is visible, and the expression
; otherwise).
(defvar show-paren-style 'mixed)

; Non-nil means the HL-Line mode highlight appears in all windows.
; Otherwise Hl-Line mode will highlight only in the selected
; window.
(defvar hl-line-sticky-flag t)

; Global Auto Revert mode is a global minor mode that reverts any
; buffer associated with a file when the file changes on disk.  Use
; `auto-revert-mode' to revert a particular buffer.
(global-auto-revert-mode t)

; Non-nil if Delete-Selection mode is enabled.
(delete-selection-mode t)

; Toggle visualization of matching parens (Show Paren mode).
(show-paren-mode t)

; region is highlighted with the `region' face whenever the mark
; is active.
(transient-mark-mode t)

; Toggle column number display in the mode line (Column Number mode).
(column-number-mode t)

; Toggle line number display in the mode line (Line Number mode).
(line-number-mode t)

; Toggle line highlighting in all buffers (Global Hl-Line mode).
(hl-line-mode 1)

; Make file executable according to umask if not already executable.
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

; This command deletes whitespace characters after the last
; non-whitespace character in each line between START and END.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'misc)
; Kill up to, but not including ARGth occurrence of CHAR.
(global-set-key (kbd "M-z") 'zap-up-to-char)

;; use redo
(require 'redo+)

; Ask user a "y or n" question.  Return t if answer is "y".
; PROMPT is the string to display to ask the question.
(fset 'yes-or-no-p 'y-or-n-p)
