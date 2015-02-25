; Hi emacs! Let me introduce myself. 

;;; Code:
(setq user-full-name "Sefa Kilic")
(setq user-mail-address "sefakilic@gmail.com")

(add-to-list 'load-path "/home/sefa/.emacs.d")

;; package management
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; increase/decrease font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(set-frame-font "monospace-10")
(line-number-mode 1)                  ;; Show line-number in the mode line
(column-number-mode 1)                ;; Show column-number in the mode line
(scroll-bar-mode -1)                  ;; use scrollbar
(tool-bar-mode -1)                    ;; display toolbar

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

; window switching
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; cut-copy-paste to/from emacs
(setq x-select-enable-clipboard t)

;; Place all backup and autosave files into a directory
(setq backup-by-copying t                             ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)                              ; use versioned backups

;; When you visit a file, go to the last place where the point was.
(require 'saveplace)
(setq-default save-place t)

;; emacs windows resize
(global-set-key (kbd "M-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-s-<down>") 'shrink-window)
(global-set-key (kbd "M-s-<up>") 'enlarge-window)

;; regex-aware search keybindings
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

; terminal
(global-set-key (kbd "C-x t") 'ansi-term)
(add-hook 'term-mode-hook (lambda() (yas-minor-mode -1)))

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
;(require 'zenburn-theme)               

;; Kill all buffers, except the current one
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; mediawiki
(require 'mediawiki)

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
(require 'pos-tip)
(setq ac-quick-help-prefer-pos-tip t)

; on the syntax checking and linting
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; HTML-mode
;;(add-hook 'html-mode-hook 'html-autoview-mode)

;; python-mode
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
)

;;; bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda () 
     (define-key python-mode-map "\C-m" 'newline-and-indent)))

(require 'fill-column-indicator)
(add-hook 'python-mode-hook (lambda () (fci-mode 1)))
(add-hook 'org-mode-hook (lambda () (fci-mode 1)))

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

;; haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; R-markdown
(require 'polymode)
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-markdown+r-mode))

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

;; use ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

; orgmode .org to pdf
(setq org-latex-to-pdf-process (list "latexmk -pdf %f %s"))

(setq org-export-latex-table-caption-above nil)

;; latex
(require 'tex)
(TeX-global-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


;; spell checking
(add-hook 'org-mode-hook (lambda() (flyspell-mode 1)))
(add-hook 'LaTeX-mode-hook (lambda () (flyspell-mode 1)))
(add-hook 'markdown-mode-hook (lambda () (flyspell-mode 1)))
(setq ispell-personal-dictionary "~/.emacs.d/.aspell.en.pws")

;; language tool
(require 'langtool)
(setq langtool-java-bin "/usr/bin/java")
(setq langtool-language-tool-jar "/usr/share/java/languagetool-commandline.jar")

; flyspell for comments in source code
(add-hook 'python-mode-hook (lambda () (flyspell-prog-mode)))
(add-hook 'c++-mode-hook (lambda () (flyspell-prog-mode)))
(add-hook 'haskell-mode-hook (lambda () (flyspell-prog-mode)))

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

; load pianobar, to run: M-x pianobar
(autoload 'pianobar "pianobar" nil t)
(setq pianobar-username "sefakilic@gmail.com")
; s-m (music)
(global-set-key (kbd "s-m m") 'pianobar)
(global-set-key (kbd "s-m n") 'pianobar-next-song)
(global-set-key (kbd "s-m c") 'pianobar-change-station)
(global-set-key (kbd "s-m l") 'pianobar-love-current-song)
(global-set-key (kbd "s-m h") 'pianobar-ban-current-song)
(global-set-key (kbd "s-m p") 'pianobar-play-or-pause)

; babel
(org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . nil)
        (R . t)
        (python . t)))

;; emacs ipython notebook setup
(require 'ein)
; setup auto-completion using EIN and jedi.el together
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)

;;; init.el ends here

