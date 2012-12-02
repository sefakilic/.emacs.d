;; Hi emacs! Let me introduce myself.
(setq user-full-name "Sefa Kilic")
(setq user-mail-address "sefakilic@gmail.com")

(add-to-list 'load-path "~/.emacs.d/")

(set-default-font "monaco-10")       ;; Set font
(line-number-mode 1)                  ;; Show line-number in the mode line
(column-number-mode 1)                ;; Show column-number in the mode line
(scroll-bar-mode -1)                  ;; use scrollbar
(tool-bar-mode -1)                    ;; display toolbar
(turn-on-auto-fill)                   ;; auto-fill mode


;; Turn on Auto Fill mode automatically in all modes.
;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.
;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.
(setq-default fill-column 80)
(setq auto-fill-mode 1)

;; autopair
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers 
;; show paren mode
(show-paren-mode 1)

;; make buffer names unique
(require 'uniquify)
(set 'uniquify-buffer-name-style 'forward) 

;; HTML-mode
;;(add-hook 'html-mode-hook 'html-autoview-mode)

;; python-mode
;; lazy way to install python-mode in ubuntu: sudo apt-get install python-mode
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(require 'ipython) ; use ipython as python shell

;; scheme-mode
;; load-scheme
(require 'xscheme)
(add-hook 'scheme-mode-hook
	  (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

;; cmode
(add-hook 'c-mode-common-hook
	  (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

;; dired settings
;; Dired copy folders recursively without confirmation
(setq dired-recursive-copies 'always)

;; color-theme
;; for color-theme package install emacs-goodies
(require 'zenburn)
(zenburn)

;; Kill all buffers, except the current one
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))
