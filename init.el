; Travis Westura
; emacs init file

(global-linum-mode t)  ; Line numbering
(global-hl-line-mode t)  ; Highlight current row
(show-paren-mode t)  ; match parentheses and the like
(setq inhibit-splash-screen t)  ; Disable splash screen
(tool-bar-mode -1)  ; No toolbar
(menu-bar-mode -1)  ; No menu bar
(fset 'yes-or-no-p 'y-or-n-p)  ; change yes or no options to y or n

; set the default frame width to 90 characters
; Note that line numbers take space on the side
(add-to-list 'default-frame-alist '(width . 90))

(setq make-backup-files nil)  ; stop creating backup~ files
(setq auto-save-default nil)  ; stop creating #autosave# files

(line-number-mode 1)  ; Display line number in the mode line
(column-number-mode 1)  ; Display column number in the mode line

; Sets the default mode for unknown files to text mode
(setq-default major-mode 'text-mode)

; Sets the default width for auto-fill-mode
(setq-default fill-column 80)

; auto insert parentheses
;(electric-pair-mode 1)

; auto-pair mode
; https://github.com/capitaomorte/autopair
(add-to-list 'load-path "~/.emacs.d/autopair/")
(require 'autopair)
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

; color scheme
; https://github.com/bbatsov/zenburn-emacs
(add-to-list 'custom-theme-load-path "~/.emacs.d/zenburn-emacs/")
(load-theme 'zenburn t)

; auto-complete
; https://github.com/auto-complete/auto-complete
; (The github did not work, so I downloaded it from the website)
; http://cx4a.org/software/auto-complete/#Latest_Stable
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1/")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict/")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

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

; ==============================================================================

; C

(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)


; ==============================================================================

