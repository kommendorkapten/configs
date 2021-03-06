;; First things first!
(when (eq system-type 'darwin)
  (add-to-list 'load-path "/usr/share/emacs/site-lisp")
  (add-to-list 'load-path "/usr/local/share/emacs/site-lisp"))
(when (eq system-type 'usg-unix-v)
  (add-to-list 'load-path "/usr/share/emacs/site-lisp"))
(when (eq system-type 'berkely-unix)
  (add-to-list 'load-path "/usr/local/share/emacs/site-lisp"))
;; -----------------------------
;; E N C O D I N G   S T U F F
;; -----------------------------
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

;; -----------------------------
;; V I S U A L   B E H A V I O R
;; -----------------------------
(defvar bgcolor "rgb:ce/cd/dc")
(defvar fgcolor "rgb:00/00/00")
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(show-paren-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

(when window-system
  (set-face-background 'fringe bgcolor)
  (set-face-foreground 'fringe fgcolor)
  (set-face-background 'highlight "black")
  (set-face-foreground 'highlight "lightgray")
  (set-face-attribute 'mode-line nil :box 1)
  (set-face-foreground 'mode-line     fgcolor)
  (set-face-background 'mode-line     bgcolor))
(if window-system
    (progn (set-background-color bgcolor)
	   (set-foreground-color fgcolor)
	   (set-face-foreground 'font-lock-string-face "darkviolet")
	   (set-face-foreground 'font-lock-comment-face "darkgreen")
	   (set-face-foreground 'font-lock-function-name-face "darkblue")
	   (set-face-foreground 'font-lock-keyword-face "darkblue")
	   (set-face-foreground 'font-lock-builtin-face "darkorchid" );"darkslateblue")
	   (set-face-foreground 'font-lock-variable-name-face "darkslateblue")
	   (set-face-foreground 'font-lock-type-face "blue")
	   (make-face-bold 'font-lock-function-name-face)
	   (make-face-bold 'font-lock-variable-name-face)
	   (make-face-italic 'font-lock-comment-face)
	   (set-face-underline-p 'font-lock-function-name-face t)
	   ;(set-default-font "-*-clean-medium-r-normal--12-*-*-*-c-60-iso8859-1")
	   ;(set-default-font "-*-Andale_Mono-medium-r-normal-*-11-*-*-*-*-*-*-1" )
	   ;(set-default-font "-*-monofur-medium-r-normal-*-13-*-*-*-*-*-*-1" )
           (if (eq system-type 'darwin)
               (set-default-font "-*-Source Code Pro-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
             (set-default-font "-*-Courier-Medium-R-Normal--12-*-*-*-M-*-ISO8859-1"))
	   )
  (progn
    (set-face-attribute 'mode-line nil :box 1)
    (set-face-background 'mode-line     "white")
    (set-face-foreground 'font-lock-comment-face "blue")
    (set-foreground-color "magenta")))
(set-cursor-color "magenta")
(transient-mark-mode t)
; Disable creation of new buffers
; Altering the split height/width treshold does not work :(
(setq pop-up-windows nil)
(defun no-new-display-buffer (buf not-this-window)
  (if (and (not pop-up-frames)
           (one-window-p)
           (or not-this-window
               (not (eq (window-buffer (selected-window)) buf)))
           (> (frame-width) 162))
      (split-window-horizontally))
  ;; Note: Some modules sets `pop-up-windows' to t before calling
  ;; `display-buffer' -- Why, oh, why!
  (let ((display-buffer-function nil)
        (pop-up-windows nil))
    (display-buffer buf not-this-window)))
(setq display-buffer-function 'no-new-display-buffer)
(global-hl-line-mode 1)
(set-face-background 'highlight "rgb:99/99/bb")
(set-face-foreground 'highlight nil)
(set-face-underline-p 'highlight nil) ; t for underline

;; White space mode
(require 'whitespace)
(set-face-attribute 'whitespace-line nil :background nil :foreground nil)
(set-face-attribute 'whitespace-space nil :background nil :foreground "rgb:aa/aa/aa")
(set-face-attribute 'whitespace-indentation nil :background nil :foreground "rgb:aa/aa/aa")
(set-face-attribute 'whitespace-space-before-tab nil :background "rgb:cc/00/00" :foreground "black")
(set-face-attribute 'whitespace-space-after-tab nil :background "rgb:cc/00/00" :foreground "black")
(set-face-attribute 'whitespace-trailing nil :background "rgb:cc/00/00" :foreground "black")
(set-face-attribute 'whitespace-empty nil :background "rgb:88/44/44" :foreground "black")
(set-face-attribute 'whitespace-hspace nil :background nil :foreground "darkgreen")
(set-face-attribute 'whitespace-tab nil :background nil :foreground "darkblue")

;; --------------------------------------
;; N E A T   S T U F F
;; --------------------------------------
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default ispell-program-name "aspell")
(if (eq system-type 'darwin)
    (setq ring-bell-function 'ignore)
  (setq visible-bell t))
(setq-default truncate-lines t)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;(setq auto-save-default nil)

;; -----------------------------------
;; P O W E R   S T U F F
;; -----------------------------------
(defun add-braces()
  (interactive)
  (princ "{" (current-buffer))
  (indent-according-to-mode)
  (newline-and-indent)
  (newline)
  (princ "}" (current-buffer))
  (indent-according-to-mode)
  (previous-line 1)
  (end-of-line))

(defun add-brackets()
  (interactive)
  (princ "[]" (current-buffer))
  (backward-char))

(defun add-parenthesis()
  (interactive)
  (princ "()" (current-buffer))
  (backward-char))

;; --------------------------------------
;; K E Y   B I N D I N G S
;; --------------------------------------
(defun left-slightly() (interactive) (scroll-left 3))
(defun right-slightly() (interactive) (scroll-right 3))
(defun up-three() (interactive) (scroll-up 2))
(defun down-three() (interactive) (scroll-down 2))

(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))

(global-set-key [delete] 'delete-char)
(global-set-key "\C-h" 'delete-backward-char)

(global-set-key [?\M-g] 'goto-line)
(global-set-key [(control tab)] 'dabbrev-expand)
(global-set-key [�] 'dabbrev-expand)
(global-set-key [?\C-7] 'add-braces)
(global-set-key [?\C-8] 'add-brackets)
(global-set-key [?\C-9] 'add-parenthesis)
(global-set-key [f4] 'menu-bar-mode)
(global-set-key [f5] 'toggle-truncate-lines)

(global-set-key [f1] 'show-subtree)
(global-set-key [f2] 'hide-subtree)
(global-set-key [f3] 'hide-other)

(global-set-key [left] 'backward-word)
(global-set-key [right] 'forward-word)
(global-set-key [up] 'backward-paragraph)
(global-set-key [down] 'forward-paragraph)

(global-set-key [S-right] 'enlarge-window-horizontally)
(global-set-key [S-left]  'shrink-window-horizontally)
(global-set-key [S-up]    'enlarge-window)
(global-set-key [S-down]  'shrink-window)
(global-set-key [S-next] 'previous-multiframe-window)
(global-set-key [S-prior] 'other-window)

;; Buffer movement
(global-set-key [M-up] 'up-three)
(global-set-key [M-down] 'down-three)
(global-set-key [M-left] 'left-slightly)
(global-set-key [M-right] 'right-slightly)

;; Scroll wheel
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)


;; OS based configuration
;; OSX
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'none)
  (setq mac-command-modifier 'meta))
; use OSX cmd button as meta in *NIX
;(setq x-super-keysym 'meta)

;; Solaris
(when (eq system-type 'usg-unix-v)
  (setq x-alt-keysym 'meta)
  (setq find-program "gfind"))


; Emacs std bindings
; C-x r m add bookmark
; C-x r b jump to bookmark
; C-x r l list bookmark
; M-x bookmark-delete

;; ------------------------------
;; F I L E   M O D E S
;; ------------------------------
(require 'go-mode)
(autoload 'dtrace-script-mode "dtrace-script-mode" "Major mode for dtrace" t)
;(require 'yaml-mode)
;(autoload 'php-mode "php-mode" "Major mode for edit php" t)

(setq c-default-style
      '((java-mode . "bsd")
	(c-mode . "bsd")
	(go-mode . "bsd")
	(dtrace-script-mode . "bsd")
	(c++-mode . "bsd")
	(other . "bsd")))

(setq auto-mode-alist
      (append '(("\\.pad\\'" . pascal-mode)
		("\\.spl\\'" . pascal-mode)
		("\\.xhtml\\'" . nxml-mode)
		("\\.go\\'" . go-mode)
		("\\.d\\'" . dtrace-script-mode)
		("\\.json\\'" . javascript-mode)
		("\\.md\\'" . text-mode)
	        ("\\.ici\\'" . c-mode ) )
	      auto-mode-alist))

;; -----------------------------
;; T A B S / S P A C E S
;; -----------------------------
; Or first line in file
; /* -*- mode: java; c-basic-offset: 8; indent-tabs-mode: nil -*- */
(setq default-tab-width 8)
(setq tab-width default-tab-width)
(setq c-basic-offset tab-width)
(setq nxml-child-indent 4)
(setq js-indent-level 4)
(setq css-indent-offset 4)
(setq-default indent-tabs-mode nil) ; use spaces
;(setq indent-tabls-mode t) ; use tabs
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; -----------------------------
;; Personal remainder stuff
;; -----------------------------
;(setq x-alt-keysym 'meta)
;; '(font-lock-comment-face ((((class color) (background light))
;; 			   (:italic t :foreground "Firebrick"))))
;; '(font-lock-function-name-face ((((class color) (background light))
;; 				 (:bold t :foreground "Blue"))))
;; '(font-lock-keyword-face ((((class color) (background light))
;; 			   (:bold t :foreground "Black"))))
;; '(font-lock-string-face ((((class color) (background light))
;; 			  (:italic t :foreground "ForestGreen"))))
;; '(font-lock-type-face ((((class color) (background light))
;; 			(:foreground "Blue"))))
;; '(font-lock-variable-name-face ((((class color) (background light))
;; 				 (:foreground "Black"))))
;; '(font-lock-reference-face ((((class color) (background light))
;; 			     (:foreground "ForestGreen")))))

;;M-x list-faces-display
;; 'modeline the status row
;; 'region   the marked region
;;(make-face-bold 'face)
;;(set-face-underline-p 'face t)

;; MediumAquamarine, magenta, LightSkyBlue, midnightblue, DarlSlateGrey
;; PaleGreen, forest green, dark orchid, steel blue, plum, gold dark turquoise

;; -----------------------------
;;  A U T O   G E N   S T U F F
;; -----------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t nil (paren))
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 20) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t))))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
