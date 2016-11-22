; Set attributes of FACE on FRAME from ARGS.
(set-face-attribute 'default nil :family "Menlo" :height 120)

; Modify fontset NAME to use FONT-SPEC for TARGET characters.
; NAME is a fontset name string, nil for the fontset of FRAME, or t for
; the default fontset.
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Hiragino Kaku Gothic ProN"))

(defun font-big ()
  (interactive)
  (set-face-attribute 'default nil :family "Menlo" :height 200))

(defun font-small ()
  (interactive)
  (set-face-attribute 'default nil :family "Menlo" :height 120))
