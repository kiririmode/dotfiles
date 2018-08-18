(add-to-list 'default-frame-alist '(font . "Ricty Diminished Discord-12"))

(setq default-frame-alist
      (append (list
               '(width . 220)
               '(height . 60)
               '(top . 0)
               '(left . 0)
               '(alpha . 0.85))
              default-frame-alist))

; Toggle maximization state of the selected frame.
; (toggle-frame-maximized)
(global-set-key (kbd "C-x x m") 'toggle-frame-maximized)
(global-set-key (kbd "C-x x z") 'toggle-frame-fullscreen)
