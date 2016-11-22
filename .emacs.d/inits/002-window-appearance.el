;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; Window Appearance

; Template for displaying the title bar of visible frames.
(setq frame-title-format (format "%%f"))

; Toggle the tool bar in all graphical frames (Tool Bar mode).
(tool-bar-mode 0)

; Toggle Font-Lock mode in all buffers.
(global-font-lock-mode t)

; Load Custom theme named THEME from its file.
; The theme file is named THEME-theme.el, in one of the directories
; specified by `custom-theme-load-path'.
(load-theme 'atom-dark t)
