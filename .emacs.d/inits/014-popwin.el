(require 'popwin)

; Non-nil if Popwin mode is enabled.
(popwin-mode 1)

; The value is a list of
; CONFIG as a form of (PATTERN . KEYWORDS) where PATTERN is a
; pattern of specifying buffer and KEYWORDS is a list of a pair of
; key and value. PATTERN is in general a buffer name, a symbol
; specifying major-mode of buffer, or a predicate function which
; takes one argument: the buffer.
(setq popwin:special-display-config
      '(
        ("*Help*"             :height 0.5 :noselect nil :stick nil)
        ("*godoc \.\*"        :width  0.5 :noselect nil :stick nil :regexp t :position right)
        ("*git-gutter:diff*"  :height 0.5 :noselect nil :stick t)
        ("*magit\.\*"         :height 0.5 :noselect nil :stick nil :regexp t)
        ("*Compile-Log*"      :height 0.5 :noselect nil :stick nil)
        ("*helm-for-files*"   :height 0.5 :noselect nil :stick nil)
        ("*RE-Builder*")
        ("*golint*")
        ("*Gofmt Errors*"                 :noselect nil :stick nil)))
