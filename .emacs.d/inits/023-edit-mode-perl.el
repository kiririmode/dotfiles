(require 'cperl-mode)
(defalias 'perl-mdoe 'cperl-mode)

(add-to-list 'auto-mode-alist '("\\.t$"     . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.cgi$"   . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.psgi$"  . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pl$"    . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile$" . cperl-mode))

(eval-after-load "cperl-mode"
  '(progn
     (setq
      ; Indentation of CPerl statements with respect to containing block.
      cperl-indent-level 4
      ; Extra indent for lines not starting new statements.
      cperl-continued-statement-offset 4
      ; Extra indent for substatements that start with close-parenthesis.
      cperl-close-paren-offset -4
      ; Column to put comments in CPerl
      cperl-comment-column 40
      ; Non-nil means perform additional highlighting on variables.
      cperl-highlight-variables-indiscriminately t
      ; Non-nil means that non-block ()-, {}- and []-groups are indented as blocks,
      ; but for trailing "," inside the group, which won't increase indentation.
      cperl-indent-parens-as-block t
      ; Offset of CPerl label lines relative to usual indentation.
      cperl-label-offset -4
      ; Non-nil means TAB in CPerl mode should always reindent the current line,
      ; regardless of where in the line point is when the TAB command is used.
      cperl-tab-always-indent nil
      ; Non-nil (and non-null) means CPerl buffers will use `font-lock-mode'.
      cperl-font-lock t)

     (require 'helm-perldoc)
     (helm-perldoc:setup)))
