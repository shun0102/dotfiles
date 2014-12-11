;;(require 'cask)
;;(cask-initialize)
(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)

;;行と列番号を表示
(line-number-mode t)
(column-number-mode t)

;;起動時の画面を消す
(setq inhibit-startup-message t)

;;背景を黒の透明色にする
(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 80)
   ))

(set-face-attribute 'default nil :height 140)

(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 )

(elscreen-start)
(elscreen-set-prefix-key "\C-t")
(global-set-key "\M-t" 'elscreen-create)
(global-set-key "\M-T" 'elscreen-clone)
(global-set-key "\M-n" 'elscreen-next)
(global-set-key "\M-p" 'elscreen-previous)
(global-set-key "\M-q" 'elscreen-kill)

(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil);;; *.~ とかのバックアップファイルを作らない


(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
(global-set-key "\C-x@" '(lambda ()
                           (interactive)
                           (split-window-horizontally-n 3)))

(add-hook 'json-mode-hook
          (lambda ()
            (setq js-indent-level 2)))
