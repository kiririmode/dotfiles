(require 'anzu)

; Toggle Anzu mode in all buffers.
(global-anzu-mode +1)

(setq
 ; Lighter of anzu-mode
 anzu-mode-lighter ""
 ; Limit of search number
 anzu-search-threshold 1000
 ; Deactive region if you use anzu a replace command with region
 anzu-deactivate-region t)

(set-face-attribute 'anzu-mode-line nil
                    :foreground "black" :weight 'bold)

; anzu version of `query-replace'.
(global-set-key (kbd "M-%") 'anzu-query-replace)
