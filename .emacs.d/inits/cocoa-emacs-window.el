;;; Cocoa Emacs ÍÑÀßÄê
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq
 ; This variable describes the behavior of the command key.
 ; Set to control, meta, alt, super, or hyper means it is taken to be that key.
 ns-command-modifier 'meta)

; Alist of default values for frame creation.
(setq default-frame-alist
      (append (list
               '(width . 220)
               '(height . 80)
               '(top . 0)
               '(left . 0)
               '(alpha . 0.85))
              default-frame-alist))
