;; Hi emacs! Let me introduce myself. 
(setq user-full-name "Sefa Kilic")
(setq user-mail-address "sefakilic@gmail.com")

(add-to-list 'load-path "/home/sefa/.emacs.d")

;; package management
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)



(set-default-font "DejaVu Sans Mono-10")
;;(set-default-font "monospace-10")
(line-number-mode 1)                  ;; Show line-number in the mode line
(column-number-mode 1)                ;; Show column-number in the mode line
(scroll-bar-mode -1)                  ;; use scrollbar
(tool-bar-mode -1)                    ;; display toolbar

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(require 'fill-column-indicator)
(add-hook 'python-mode-hook (lambda () (fci-mode 1)))
(add-hook 'org-mode-hook (lambda () (fci-mode 1)))

;; cut-copy-paste to/from emacs
(setq x-select-enable-clipboard t)

;; Place all backup and autosave files into a directory
(setq backup-by-copying t                             ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)                              ; use versioned backups

;; emacs windows resize
(global-set-key (kbd "M-s-<left>") 'shrink-window-horizontally)
    (global-set-key (kbd "M-s-<right>") 'enlarge-window-horizontally)
    (global-set-key (kbd "M-s-<down>") 'shrink-window)
    (global-set-key (kbd "M-s-<up>") 'enlarge-window)

;; autopair
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers 

;; show paren mode
(show-paren-mode 1)

;; make buffer names unique
(require 'uniquify)
(set 'uniquify-buffer-name-style 'forward) 

;; dired settings
;; Dired copy folders recursively without confirmation
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
;; sort directories first
(setq dired-listing-switches "-alh --group-directories-first")
;; dired omit files
(require 'dired-x) 
(setq dired-omit-files 
      (rx (or (seq bol (? ".") "#")         ;; emacs autosave files 
              (seq "~" eol)                 ;; backup-files 
              (seq bol "svn" eol)           ;; svn dirs 
              (seq ".pyc" eol)
              ))) 
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1))) 


;; delete by moving to trash
(setq delete-by-moving-to-trash t)

;; color-theme
;; for color-theme package install emacs-goodies
(require 'zenburn-theme)

;; Kill all buffers, except the current one
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; mediawiki
(require 'mediawiki)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-use-quick-help t)
 '(column-number-mode t)
 '(mediawiki-site-alist (quote (("erilllab" "http://erilllab.biosci.umbc.edu/wiki/" "sefa1" "" "Main Page"))))
 '(mediawiki-site-default "erilllab")
 '(org-agenda-files nil t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; text mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; programming modes
(require 'auto-complete)
(setq ac-max-width 80)


;; HTML-mode
;;(add-hook 'html-mode-hook 'html-autoview-mode)

;; python-mode
;; lazy way to install python-mode in ubuntu: sudo apt-get install python-mode
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(require 'ipython)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; scheme-mode
;; load-scheme
(require 'xscheme)
(add-hook 'scheme-mode-hook
	  (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

;; cmode
(add-hook 'c-mode-common-hook
	  (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

;; octave mode
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/yasnippet/snippets"))
(yas-global-mode 1)
;; stop yasnippet auto-indent
(setq yas/indent-line 'fixed)

;; tetris score file
(setq tetris-score-file "~/emacs.d/tetris.score")

;; calendar
(setq calendar-week-start-day 1)

; jabber configuration
(setq jabber-account-list
      '(("sefa1@umbc.edu"
         (:network-server . "talk.google.com")
         (:connection-type . ssl))))

; interactively do things
; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)

; orgmode .org to pdf
(setq org-latex-to-pdf-process '("pdflatex -interaction nonstopmode %b"
                                 "bibtex %b"
                                 "pdflatex -interaction nonstopmode %b"
                                 "pdflatex -interaction nonstopmode %b"))

(setq org-export-latex-table-caption-above nil)

;; latex
(setq TeX-PDF-mode t)


;; spell checking
(add-hook 'org-mode-hook (lambda() (flyspell-mode 1)))
(add-hook 'LaTeX-mode-hook (lambda () (flyspell-mode 1)))
(setq ispell-personal-dictionary "~/.emacs.d/.aspell.en.pws")

; flyspell for comments in source code
;(add-hook 'python-mode-hook (lambda () (flyspell-prog-mode)))
;(add-hook 'c++-mode-hook (lambda () (flyspell-prog-mode)))
;(add-hook 'haskell-mode-hook (lambda () (flyspell-prog-mode)))

; magit
(global-set-key (kbd "C-x g") 'magit-status)
; start eshell or switch to it if one is active
(global-set-key (kbd "C-x e") 'eshell)

; comment region
(global-set-key (kbd "C-x C-;") 'comment-region)

;; org mode agenda
(setq org-agenda-files (list "~/Dropbox/org/things.org"))
(global-set-key (kbd "C-c a") 'org-agenda)
(defun things()
  (interactive)
  (find-file "~/Dropbox/org/things.org"))
