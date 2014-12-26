;;; init.el -- Summary
; Initialization for Emacs

;;; Commentary:
; Travis Westura
; Emacs init file

; Unfortunately it seems like the git repositories that I clone
; are not uploaded to GitHub, so I need to clone them again.
; TODO: make a bash script to do the cloning for me

;;; Code:
;; =============================================================================
;; No external repositories are required for this section.
;; =============================================================================

(global-linum-mode t) ; Line numbering
(global-hl-line-mode t) ; Highlight current row
(show-paren-mode t) ; match parentheses and the like
(setq inhibit-splash-screen t) ; Disable splash screen
(tool-bar-mode -1) ; No toolbar
(menu-bar-mode -1) ; No menu bar
(fset 'yes-or-no-p 'y-or-n-p) ; change yes or no options to y or n

; set the default frame width to 90 characters
; Note that line numbers take space on the side
(add-to-list 'default-frame-alist '(width . 90))

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(size-indication-mode 1) ; Display the percentage of buffer above window top
(line-number-mode 1) ; Display line number in the mode line
(column-number-mode 1) ; Display column number in the mode line

(delete-selection-mode 1) ; Delete the region like a normal editor

; require final newlines in files when they are saved
(setq require-final-newline t)

; Set font
(set-frame-font "DejaVu Sans Mono-10")

; Sets the default mode for unknown files to text mode
(setq-default major-mode 'text-mode)

; Sets the default width for auto-fill-mode
(setq-default fill-column 80)

;; update buffer when changed externally
(global-auto-revert-mode 1)

;; http://stackoverflow.com/questions/445873/how-can-i-make-emacs-mouse-scrolling-slower-and-smoother
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;; mouse wheel scrolling
(setq mouse-wheel-progressive-speed nil)

;; make the cursor a bar
(setq-default cursor-type 'bar)

;; http://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or current line if there's no region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

;; http://www.emacswiki.org/emacs/BackToIndentationOrBeginning
(defun back-to-indentation-or-beginning ()
  "Smarter move to beginning of line."
  (interactive)
  (if (= (point) (progn (back-to-indentation) (point)))
      (beginning-of-line)))
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(idle-change save mode-enabled))

;; Interactively do things
(require 'ido)
(ido-mode t)

;; melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; =============================================================================
;; Items in this section may require external packages, mostly github repos.
;; I have included links to downloads and/or instructions.
;; =============================================================================

;; Aspell
(add-to-list 'exec-path "/usr/bin/aspell/")
(setq ispell-program-name "aspell")
(setq ispell-personal-dictionary "/usr/bin/aspell/dict")
(require 'ispell)

;; cask
;; how to install: http://cask.readthedocs.org/en/latest/guide/installation.html
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; auto-pair mode
;; https://github.com/capitaomorte/autopair
(add-to-list 'load-path "~/.emacs.d/autopair")
(require 'autopair) ; I do not know why this error appears, the file seems fine
(autopair-global-mode)
;(setq autopair-autowrap t)

;; indent guide
;; https://github.com/zk-phi/indent-guide
(add-to-list 'load-path "~/.emacs.d/indent-guide")
(require 'indent-guide)
(indent-guide-global-mode)

;; fill column indicator
;; https://github.com/alpaker/Fill-Column-Indicator
(add-to-list 'load-path "~/.emacs.d/Fill-Column-Indicator/")
(require 'fill-column-indicator)
(define-globalized-minor-mode
global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

;; undo-tree (to get easier redo)
;; http://www.dr-qubit.org/undo-tree/undo-tree-0.6.4.el
;; git clone http://www.dr-qubit.org/git/undo-tree.git
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(require 'undo-tree)
(global-undo-tree-mode 1)

;; magit
;; https://github.com/magit/magit
;; after cloning, cd into the directory and run make lisp docs
;; https://github.com/magit/git-modes
(add-to-list 'load-path "/path/to/git-modes")
(add-to-list 'load-path "/path/to/magit")
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "/path/to/magit/")))
(require 'magit)

; sr-speedbar
; http://www.emacswiki.org/emacs/download/sr-speedbar.el
(add-to-list 'load-path "~/.emacs.d/speedbar")
(require 'sr-speedbar)

; dash
; https://github.com/magnars/dash.el
(add-to-list 'load-path "~/.emacs.d/dash")
(require 'dash)
; include to get syntax highlighting
(eval-after-load "dash" '(dash-enable-font-lock))
; Note that dash is needed for the smart mode line

; smart mode line
; https://github.com/Bruce-Connor/smart-mode-line
; Inside of the previous folder, clone
; https://github.com/Bruce-Connor/rich-minority
(add-to-list 'load-path "~/.emacs.d/smart-mode-line")
(add-to-list 'load-path "~/.emacs.d/smart-mode-line/rich-minority")
(require 'smart-mode-line)
(require 'rich-minority)
(setq sml/no-confirm-load-theme t)
(sml/setup)

; color scheme
; https://github.com/bbatsov/zenburn-emacs
(add-to-list 'custom-theme-load-path "~/.emacs.d/zenburn-emacs/")
(load-theme 'zenburn t)

;; =============================================================================
;; This section contains extensions specific to working with C code.
;; =============================================================================


(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)

; spelling of comments
(add-hook 'c-mode-hook 'flyspell-prog-mode)

;; =============================================================================
;; This section is for python.
;; On my version of arch, I decided to use Python 3, which was the default when
;; simply installing python using pacman.
;; =============================================================================

; python-mode
; https://github.com/emacsmirror/python-mode
; seems like this is the official website
; https://launchpad.net/python-mode
(setq py-install-directory "~/.emacs.d/python-mode/")
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

;; TODO figure out rope pickle error in python 3

;; =============================================================================
;; LaTeX
;; =============================================================================

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

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

(setq preview-image-type 'pnm)

(setq TeX-save-query nil) ;;autosave before compiling

;; Folding
;; http://www.flannaghan.com/2013/01/11/tex-fold-mode
(add-hook 'LaTeX-mode-hook
		  (lambda ()
			(TeX-fold-mode 1)
			(add-hook 'find-file-hook 'TeX-fold-buffer t t)))

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

;; =============================================================================

;;; init.el ends here

