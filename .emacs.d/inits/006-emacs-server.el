(require 'server)

; if emacs server does not seem to be running, start the server.
(unless (server-running-p)
  (server-start))

; disable asking before killing a server buffer.
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
