;;; init.el -- Summary
; Initialization for Emacs

;;; Commentary:
; Travis Westura
; Emacs init file

; Unfortunately it seems like the git repositories that I clone
; are not uploaded to GitHub, so I need to clone them again.

;;; Code:
(global-linum-mode t)  ; Line numbering
(global-hl-line-mode t)  ; Highlight current row
(show-paren-mode t)  ; match parentheses and the like
(setq inhibit-splash-screen t)  ; Disable splash screen
(tool-bar-mode -1)  ; No toolbar
(menu-bar-mode -1)  ; No menu bar
(fset 'yes-or-no-p 'y-or-n-p)  ; change yes or no options to y or n

;(server-start)  ; I hope this works, but seems easier without it

; set the default frame width to 90 characters
; Note that line numbers take space on the side
(add-to-list 'default-frame-alist '(width . 90))

(setq make-backup-files nil)  ; stop creating backup~ files
(setq auto-save-default nil)  ; stop creating #autosave# files

(size-indication-mode 1)  ; Display the percentage of buffer above window top
(line-number-mode 1)  ; Display line number in the mode line
(column-number-mode 1)  ; Display column number in the mode line

(delete-selection-mode 1)  ; Delete the region like a normal editor

; require final newlines in files when they are saved
(setq require-final-newline t)

; Set font
(set-frame-font "DejaVu Sans Mono-10")

; Sets the default mode for unknown files to text mode
(setq-default major-mode 'text-mode)

; Sets the default width for auto-fill-mode
(setq-default fill-column 80)

; ede mode
(global-ede-mode t)

; cask
; how to install: http://cask.readthedocs.org/en/latest/guide/installation.html
(require 'cask "~/.cask/cask.el")
(cask-initialize)

; auto-pair mode
; https://github.com/capitaomorte/autopair
(add-to-list 'load-path "~/.emacs.d/autopair")
(require 'autopair)  ; I do not know why this error appears, the file seems fine
(autopair-global-mode)
;(setq autopair-autowrap t)

; http://stackoverflow.com/questions/445873/how-can-i-make-emacs-mouse-scrolling-slower-and-smoother
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
; mouse wheel scrolling
(setq mouse-wheel-progressive-speed nil)

; update buffer when changed externally
(global-auto-revert-mode 1)

; Interactively do things
(require 'ido)
(ido-mode t)

; auto-complete
; https://github.com/auto-complete/auto-complete
; (The github did not work, so I downloaded it from the website)
; Trying again, it looks like the github was successful
; Or maybe not.  There is no error, but it does not seem to work
; http://cx4a.org/software/auto-complete/#Latest_Stable
;(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1/")
;(require 'auto-complete)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict/")
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-complete-mode t)

; indent guide
; https://github.com/zk-phi/indent-guide
(add-to-list 'load-path "~/.emacs.d/indent-guide")
(require 'indent-guide)
(indent-guide-global-mode)

; fill column indicator
; https://github.com/alpaker/Fill-Column-Indicator
(add-to-list 'load-path "~/.emacs.d/Fill-Column-Indicator/")
(require 'fill-column-indicator)
(define-globalized-minor-mode
    global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

; Aspell
(add-to-list 'exec-path "/usr/bin/aspell/")
(setq ispell-program-name "aspell")
(setq ispell-personal-dictionary "/usr/bin/aspell/dict")
(require 'ispell)

; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(idle-change save mode-enabled))

; company auto-complete
; https://github.com/company-mode/company-mode
(add-to-list 'load-path "~/.emacs.d/company-mode")
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

; undo-tree (to get easier redo)
; http://www.dr-qubit.org/undo-tree/undo-tree-0.6.4.el
; git clone http://www.dr-qubit.org/git/undo-tree.git
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(require 'undo-tree)
(global-undo-tree-mode 1)

; helm
; https://github.com/emacs-helm/helm
;; [Facultative] Only if you have installed async.
(add-to-list 'load-path "~/.emacs.d/emacs-async")

(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)

; dash
; https://github.com/magnars/dash.el
(add-to-list 'load-path "~/.emacs.d/dash")
(require 'dash)
; include to get syntax highlighting
(eval-after-load "dash" '(dash-enable-font-lock))

; smart mode line
(add-to-list 'load-path "~/.emacs.d/smart-mode-line")
(add-to-list 'load-path "~/.emacs.d/smart-mode-line/rich-minority")
(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(sml/setup)

; I put zenburn after the smart mode line, it changes the colors of the line

; color scheme
; https://github.com/bbatsov/zenburn-emacs
(add-to-list 'custom-theme-load-path "~/.emacs.d/zenburn-emacs/")
(load-theme 'zenburn t)

; sr-speedbar
; http://www.emacswiki.org/emacs/download/sr-speedbar.el
(add-to-list 'load-path "~/.emacs.d/speedbar")
(require 'sr-speedbar)

; Big tutorial
; http://tuhdo.github.io/c-ide.html

;(global-semantic-idle-summary-mode 1)
;(global-semantic-stickyfunc-mode 1)


;http://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or current line if there's no region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

; http://www.emacswiki.org/emacs/BackToIndentationOrBeginning
(defun back-to-indentation-or-beginning ()
  "Smarter move to beginning of line."
  (interactive)
  (if (= (point) (progn (back-to-indentation) (point)))
	  (beginning-of-line)))

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)

; ==============================================================================

; C

(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)

; spelling of comments
(add-hook 'c-mode-hook 'flyspell-prog-mode)


; ==============================================================================

; Python

; python-mode
; https://github.com/emacsmirror/python-mode
; seems like this is the official website
; https://launchpad.net/python-mode
(setq py-install-directory "~/.emacs.d/python-mode.el-6.1.3/")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

(when (featurep 'python) (unload-feature 'python t))

; spelling of comments
(add-hook 'python-mode-hook 'flyspell-prog-mode)

; pymacs
; https://github.com/pinard/Pymacs
; run make, and then python setup.py install
(add-to-list 'load-path "~/.emacs.d/Pymacs")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

; rope and ropemacs installed using pip
; https://github.com/python-rope/ropemacs
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")


; ==============================================================================

; LaTeX

; TODO figure out how to get latexmk to work on Fedora

; LaTeX options

; The following three blocks were taken from here:
; http://www.emacswiki.org/emacs/AUCTeX

(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
;;(setq-default TeX-master nil) ; use when splitting into multiple files

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq-default TeX-PDF-mode t) ; compile to pdf mode by default
(setq-default Tex-Interactive-mode t) ; Stop on errors (Interactive mode)

(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

;(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

(setq preview-image-type 'pnm)

;; Folding
;; http://www.flannaghan.com/2013/01/11/tex-fold-mode
(add-hook 'LaTeX-mode-hook
		  (lambda ()
			(TeX-fold-mode 1)
			(add-hook 'find-file-hook 'TeX-fold-buffer t t)))

(setq TeX-save-query nil) ;;autosave before compiling

;; Sentence-fill hack
;; ==================
;; https://thingsthatpassforknowledge.wordpress.com/2011/10/08/emacs-prettifies-plain-text-files-for-version-control/

(defun my-fill-latex-paragraph ()
  "Fill the current paragraph, separating sentences w/ a newline.

AUCTeX's latex.el reimplements the fill functions and is *very* convoluted.
We use part of it --- skip comment par we are in."
  (interactive)
  (if (save-excursion
		(beginning-of-line) (looking-at TeX-comment-start-regexp))
	  (TeX-comment-forward)
	(let ((to (progn
				(LaTeX-forward-paragraph)
				(point)))
		  (from (progn
				  (LaTeX-backward-paragraph)
				  (point)))
		  (to-marker (make-marker)))
	  (set-marker to-marker to)
	  (while (< from (marker-position to-marker))
		(forward-sentence)
		(setq tmp-end (point))
		(LaTeX-fill-region-as-paragraph from tmp-end)
		(setq from (point))
		(unless (bolp)
		  (LaTeX-newline))))))

(eval-after-load "latex"
  '(define-key LaTeX-mode-map (kbd "M-q") 'my-fill-latex-paragraph))

; ==============================================================================

;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(ede-project-directories (quote ("/home/twestura/Desktop/tmp/myproject/include" "/home/twestura/Desktop/tmp/myproject/src" "/home/twestura/Desktop/tmp/myproject" "/home/twestura/Desktop"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
