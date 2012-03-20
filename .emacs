(set-terminal-coding-system 'utf-8)

;; ElScreen
(setq elscreen-prefix-key "\C-t")
(require 'elscreen)
(global-set-key "\M-t" 'elscreen-create)
(global-set-key "\M-T" 'elscreen-clone)
(global-set-key "\M-n" 'elscreen-next)
(global-set-key "\M-p" 'elscreen-previous)
(global-set-key "\M-q" 'elscreen-kill)

;;自動文字コード判別をしない
(setq auto-coding-functions nil)

;;ロードパスを追加
(setq load-path(cons "~/emacs" load-path))
(setq load-path(cons "~/emacs/emacs-rails" load-path))
(setq load-path (cons "~/.emacs.d" load-path))

;;行と列番号を表示
(line-number-mode t)
(column-number-mode t)

;;起動時の画面を消す
(setq inhibit-startup-message t)

;;起動時にフルスクリーン表示
(when (eq window-system 'mac)
  (add-hook 'window-setup-hook
            (lambda ()
;;              (setq mac-autohide-menubar-on-maximize t)
              (set-frame-parameter nil 'fullscreen 'fullboth)
              )))

;;右端で折り返すための設定
(setq truncate-partial-width-windows nil)

(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 )


;;背景を黒の透明色にする
(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 80)
   ))


;;シフト押しながらキー移動で範囲選択
(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)

;;対応する括弧を光らせる
(show-paren-mode 1)

;;ruby-modeを使用
(setq interpreter-mode-alist
      (cons '("ruby" . ruby-mode) interpreter-mode-alist))
(setq auto-mode-alist
      (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(autoload 'ruby-mode "ruby-mode" nil t)
;;rails.elを読み込む
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
        try-complete-file-name
        try-expand-dabbrev))
(setq rails-use-mongrel t)
(require 'rails)

;;railsのファイル切り替え用コマンドのキーバインダ変更
(define-key rails-minor-mode-map "\C-c\C-p" 'rails-lib:run-primary-switch)
(define-key rails-minor-mode-map "\C-c\C-n" 'rails-lib:run-secondary-switch)

;;json
(setq auto-mode-alist
      (cons '("\\.json$" . js-mode) auto-mode-alist))

;; 日本語入力のON/OFFでカーソルの色を変える
(add-hook 'mw32-ime-on-hook
          (function (lambda () (set-cursor-color "Pink"))))
(add-hook 'mw32-ime-off-hook
          (function (lambda () (set-cursor-color "White"))))
(setq-default mw32-ime-mode-line-state-indicator "[--]")

(setq make-backup-files nil)

;;全角スペースとかに色づけ
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-1 '((t (:background "dark turquoise"))) nil)
(defface my-face-b-2 '((t (:background "cyan"))) nil)
(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                              (if font-lock-mode
                                  nil
                                (font-lock-mode t))))

;;丸文字フォント
(if (eq window-system 'mac)
   (progn
    (require 'carbon-font)
     (fixed-width-set-fontset "hiramaru" 12)))

;;タブをスペースに
(setq-default tab-width 8 indent-tabs-mode nil)

;;javaのインデント
(setq c-default-style
      '((java-mode . "gnu") ))


;; 保存しないファイルの正規表現
;;(setq desktop-files-not-to-save "\\(^/[^/:]*:\\|\\.diary$\\)")
;;(autoload 'desktop-save "desktop" nil t)
;;(autoload 'desktop-clear "desktop" nil t)
;;(autoload 'desktop-load-default "desktop" nil t)
;;(autoload 'desktop-remove "desktop" nil t)
;; 起動時に自動で前回の状態になる
;;(desktop-read)
;;(add-hook 'kill-emacs-hook 'desktop-save-in-desktop-dir)

;;; 最近使ったファイルを保存(M-x recentf-open-filesで開く)
(recentf-mode)

(global-set-key "\C-c\C-f" 'recentf-open-files)

;;
(setq my-print-command-format "nkf -e | e2ps -a4 -p -nh | lpr")
(defun my-print-region (begin end)
  (interactive "r")
   (shell-command-on-region begin end my-print-command-format))
(defun my-print-buffer ()
  (interactive)
  (my-print-region (point-min) (point-max)))