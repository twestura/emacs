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

; http://stackoverflow.com/questions/445873/how-can-i-make-emacs-mouse-scrolling-slower-and-smoother
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
; mouse wheel scrolling
(setq mouse-wheel-progressive-speed nil)

; update buffer when changed externally
(global-auto-revert-mode 1)

; Interactively od things
(require 'ido)
(ido-mode t)

