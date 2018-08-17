  (global-anzu-mode +1) ; Toggle Anzu mode in all buffers.

  (setq
   anzu-mode-lighter ""       ; Lighter of anzu-mode
   anzu-search-threshold 1000 ; Limit of search number
   anzu-deactivate-region t)  ; Deactive region if you use anzu a replace command with region

  (set-face-attribute 'anzu-mode-line nil
                      :foreground "black" :weight 'bold)
