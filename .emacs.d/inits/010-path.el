(require 'exec-path-from-shell)

(when (memq window-system '(mac ns))

  (setq
   ; List of environment variables which are copied from the shell.
   exec-path-from-shell-variables '("PATH" "MANPATH" "GOPATH")
   ; If non-nil, warn if variables are being set in the wrong shell startup files.
   exec-path-from-shell-check-startup-files nil)

   ; Initialize environment from the user's shell.
   ; The values of all the environment variables named in
   ; `exec-path-from-shell-variables' are set from the corresponding
   ; values used in the user's shell.
   (exec-path-from-shell-initialize))
