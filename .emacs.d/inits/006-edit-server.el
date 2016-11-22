;;;
;;; for edit-server.el
;;;
;;; edit server to respond to requests from the Chrome
;;; Emacs Chrome plugin.

;; edit server 起動
(require 'edit-server nil t)

(setq
 ; If not nil, edit each buffer in a new frame (and raise it).
 edit-server-new-frame nil
 ; A-list of patterns and corresponding functions; when the first
 ; pattern is encountered which matches `edit-server-url', the
 ; corresponding function will be called in order to set the desired
 ; major mode.
 edit-server-url-major-mode-alist '(("kiririmode\\.hatenablog\\.jp" . markdown-mode)))

; Start the edit server.
(edit-server-start)
