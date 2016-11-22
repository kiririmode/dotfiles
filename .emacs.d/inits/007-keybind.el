; Delete the previous N characters (following if N is negative).
(global-set-key (kbd "C-h") 'delete-backward-char)
; Insert a newline, and move to left margin of the new line if it's blank.
(global-set-key (kbd "C-j") 'newline)
(global-set-key (kbd "C-c h") 'help-command)
; Expands to the most recent, preceding word for which this is a prefix
(global-set-key (kbd "M-/") 'dabbrev-expand)
; Insert a newline, then indent according to major mode.
(global-set-key (kbd "C-m") 'newline-and-indent)
; Go to LINE, counting from line 1 at beginning of buffer.
(global-set-key (kbd "M-g") 'goto-line)
