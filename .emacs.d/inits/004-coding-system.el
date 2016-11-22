;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; Coding System

(setq
 ; Coding system to be used for encoding the buffer contents on saving.
 buffer-file-coding-system 'utf-8-unix)

; Make CODING-SYSTEM used for communicating with other X clients.
(set-clipboard-coding-system    'utf-8-unix)

; Set default value of various coding systems to CODING-SYSTEM.
; This sets the following coding systems:
;  o coding system of a newly created buffer
;  o default coding system for subprocess I/O
; This also sets the following values:
;  o default value used as `file-name-coding-system' for converting file names
;      if CODING-SYSTEM is ASCII-compatible
;  o default value for the command `set-terminal-coding-system'
;  o default value for the command `set-keyboard-coding-system'
;      if CODING-SYSTEM is ASCII-compatible
(set-default-coding-systems     'utf-8-unix)
; Set up multilingual environment for using LANGUAGE-NAME.
; This sets the coding system priority and the default input method
; and sometimes other things.
(set-language-environment 'utf-8)
