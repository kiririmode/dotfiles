;;; Cask Configuration
;;;
;;; Cask is a project management tool for Emacs that helps automate the
;;; package development cycle.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "~/.cask/cask.el")
(require 'eieio)

; Initialize packages under PROJECT-PATH or `user-emacs-directory'.
(cask-initialize)

;;; init-loader Configuration
;;;
;;; Loader for configuration files
(require 'init-loader)

;;
;; 00X: global configuration with emacs default packages.
;; 01X: global configuration with cask-installed packages.
;; 02X: edit mode

(setq
 ; Show loading log message if this value is t. If this value is `error-only',
 ; log message is shown only errors occured.
 init-loader-show-log-after-init "error-only"
 ; Byte-compile configuration files if this value is non-nil.
 init-loader-byte-compile nil)

; Load configuration files in INIT-DIR.
(init-loader-load "~/.emacs.d/inits")
