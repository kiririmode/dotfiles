;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; Emacs Behavior

(setq
 ; Non-nil means enter debugger if an error is signaled.
 debug-on-error t
 ; Non-nil means call this function to ring the bell.
 ring-bell-function 'ignore
 ; Maximum number of lines to keep in the message log buffer.
 message-log-max 10000
 ; Non-nil inhibits the startup screen.
 inhibit-startup-screen t
 ; Initial message displayed in *scratch* buffer at startup.
 ; If this is nil, no message will be displayed.
 initial-scratch-message nil
)
