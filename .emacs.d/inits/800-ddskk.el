(require 'skk)

(when (eq system-type 'darwin)
  (progn (setq
          ; hostname or ip address where dictionary server runs.
          skk-server-host "localhost")))

(setq
 ; Non-nil means bind `dired-jump' to C-x C-j, otherwise do not.
 dired-bind-jump nil
 ; Non-nil であれば見出し語の動的補完の機能を有効にする。
 skk-dcomp-activate t
 ; Non-nil であれば、動的補完の候補を複数表示する。
 skk-dcomp-multiple-activate t
 ; 動的補完の候補を複数表示する場合の表示数。
 skk-dcomp-multiple-rows 20
 ; 見出し語を補完する際にプレフィックス(`skk-prefix')も使うか。
 skk-comp-use-prefix t
 ; 変換候補群の表示行数。
 skk-henkan-show-candidates-rows 2
 ; 辞書バッファのコーディングシステム。
 skk-jisyo-code 'utf-8
 ; Non-nil であれば、見出し語と送り仮名が一致した候補を優先して表示する。
 skk-henkan-strict-okuri-precedence t
 ; カレントバッファでインクリメンタル・サーチを行う際の入力モード。
 skk-isearch-start-mode 'latin
)

; hook function called when skk isearch begin.
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup)
; Hook function called when skk isearch is done.
(add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup)

;; face
(set-face-foreground 'skk-dcomp-multiple-face "Black")
(set-face-background 'skk-dcomp-multiple-face "LightGoldenrodYellow")
(set-face-bold-p 'skk-dcomp-multiple-face nil)
(set-face-foreground 'skk-dcomp-multiple-trailing-face "dim gray")
(set-face-bold-p 'skk-dcomp-multiple-trailing-face nil)
(set-face-foreground 'skk-dcomp-multiple-selected-face "White")
(set-face-background 'skk-dcomp-multiple-selected-face "LightGoldenrod4")
(set-face-bold-p 'skk-dcomp-multiple-selected-face nil)

; 日本語入力モード。
(global-set-key (kbd "C-x C-j") 'skk-mode)
