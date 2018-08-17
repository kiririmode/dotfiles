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
