(require 'auto-complete)

; Set `ac-trigger-key' to `KEY'
(ac-set-trigger-key "TAB")

(setq
 ; Non-nil means a special keymap `ac-menu-map' on completing menu will be used.
 ac-use-menu-map t
 ; Max height of candidate menu.
 ac-menu-height 20
 ; Non-nil means auto-complete ignores case.
 ac-ignore-case 'smart
 ; Non-nil means use fuzzy matching.
 ac-use-fuzzy t
 ; Non-nil means `auto-complete' works based on Do What I Mean.
 ac-dwim t
)

(set-face-background 'ac-candidate-face "DarkOrchid3")
(set-face-background 'ac-candidate-face "steelblue")

; set default ac-sources and global-auto-complete-mode
(ac-config-default)

; Start auto-completion at current point.
(global-set-key (kbd "M-/") 'auto-complete)
