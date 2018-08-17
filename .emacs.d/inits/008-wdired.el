(setq
 ; If non-nil, the permissions bits of the files are editable.
 wdired-allow-to-change-permissions t
 ; If non-nil, WDired requires confirmation before actually renaming files.
 wdired-use-interactive-rename t
)

(define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)
