;;; init.el --- setup file for Emacs -*- Mode: Emacs-Lisp -*-

;;; Commentary:

;;; Code:
;; Package.el
(package-initialize)

;; Cask package manager
(require 'cask "~/.cask/cask.el")
(cask-initialize)
;; Pallet
(use-package pallet
  :config
  (pallet-mode t))

;; Language environment and character codes
(set-locale-environment nil)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Theme
;;(load-theme 'material t)
(load-theme 'material-light t)

;; Default frame
(setq default-frame-alist
  '( ;; Frame size
     (width . 80)
     (height . 40)
     ;; (alpha . (0.95 0.90))
     (line-spacing . 0)
     (show-trailing-whitespace . t)))

;; Window system
(if window-system
  (progn
    ;; Fontset
    (set-face-attribute 'default nil
      :family "Noto Sans Mono"
      :height 100)
    (set-fontset-font (frame-parameter nil 'font)
      'katakana-jisx0201
      (font-spec :family "Noto Sans Mono CJK JP"))
    (set-fontset-font (frame-parameter nil 'font)
      'japanese-jisx0208
      (font-spec :family "Noto Sans CJK JP"))
    ;; Swap backspace and delete
    (define-key function-key-map [delete] [8])
    (put 'delete 'ascii-character 8)
    ;; Show menubar on window
    (menu-bar-mode 1))
  (progn
    (load-library "term/bobcat") ; Swap BS and DEL
    (menu-bar-mode -1)))         ; Don't show menubar on terminal

;; Misc. settings
(setq frame-title-format          ; Show full path for window title
  (format "%%f - Emacs@%s" (system-name)))
(setq inhibit-startup-message t)  ; Don't show startup message
(setq initial-scratch-message "") ; Don't show initial scratch message
(setq ring-bell-function 'ignore) ; Silence bell
(tool-bar-mode -1)                ; Don't show toolbar
(scroll-bar-mode -1)              ; Don't show scrollbar
(line-number-mode t)              ; Show line number
(column-number-mode t)            ; Show column number
(setq blink-cursor-interval 1)    ; Blink cursor 1 time / second
(global-hl-line-mode t)           ; Highlight current line
(transient-mark-mode 1)           ; Highlight active region
(setq mouse-yank-at-point t)      ; Insert at current point
(setq next-line-add-newlines nil) ; Don't auto add new lines at the end
(setq kill-whole-line nil)        ; Don't kill LF when killing whole line
(setq gc-cons-threshold 1000000)  ; Garbage collection frequency
(setq max-lisp-eval-depth 1000000) ; Maximum eval'able depth
(fset 'yes-or-no-p 'y-or-n-p)     ; Make "yes or no" "y or n"
(global-auto-revert-mode 1)       ; Automatically load file changes
(save-place-mode 1)               ; Save cursor place
(which-function-mode 1)           ; Show function/variable info
(with-eval-after-load 'dired      ; Dired-x
  (require 'dired-x))
(savehist-mode 1)                 ; Save minibuffer history
(setq history-length 1000)
(setq eol-mnemonic-unix "(LF)"    ; Show newline code (CR, CRLF, LF)
  eol-mnemonic-dos "(CRLF)"
  eol-mnemonic-mac "(CR)"
  eol-mnemonic-undecided "(??)")
(setq scroll-conservatively 35    ; Scroll vertically a line at a time
  scroll-margin 0
  scroll-step 1)
(set-variable 'comint-scroll-show-maximum-output t)
(display-time-mode t)             ; Show date/time on mode line
(set-variable 'display-time-string-forms
  '((format "%s/%s/%s(%s)%s:%s"
      year month day dayname 24-hours minutes)))
(set-variable 'tramp-copy-size-limit 1048576) ; Increase file size limit
(set-variable 'tramp-inline-compress-start-size 1048576) ; for tramp

;; Highlight matched parenthesess
(show-paren-mode t)
(set-variable 'show-paren-delay 0)
(set-variable 'show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "#AABBFF")
(set-face-foreground 'show-paren-match-face "#000000")
;; Show whitespace characters
(with-eval-after-load 'whitespace
  (set-variable 'whitespace-style
    '(face
       trailing
       tabs
       ;; empty   ; Empty lines at SOF/EOF
       space-mark
       tab-mark))
  (set-variable 'whitespace-display-mappings
    '(
       (space-mark ?\u3000 [?\u25a1])
       ;; (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
       ))
  (global-whitespace-mode 1)
  (set-face-background 'trailing-whitespace "#ffccff")
  (set-face-attribute 'whitespace-trailing nil
    :background "#ffccff"
    :underline t)
  (set-face-attribute 'whitespace-tab nil
    ;; :foreground "SkyBlue"
    :background "#ccffff"
    :underline t)
  (set-face-attribute 'whitespace-space nil
    :foreground "GreenYellow"
    :underline t))

;; Key bindings
(global-set-key (kbd "\C-x\C-b")  'buffer-menu)
(global-set-key (kbd "\C-x\C-z")  'suspend-emacs)
(global-set-key (kbd "\C-xi")     'insert-file)
(global-set-key (kbd "C-/")       'comment-or-uncomment-region)
(global-set-key (kbd "\M- ")      'set-mark-command)
(global-set-key (kbd "\M-r")      'replace-string)
(global-set-key (kbd "\M-\C-r")   'query-replace-regexp)
(global-set-key (kbd "\C-z")      'scroll-down)
(global-set-key (kbd "\M-l")      'goto-line)
(global-set-key (kbd "\eOA")      'previous-line)
(global-set-key (kbd "\eOB")      'next-line)
(global-set-key (kbd "\eOC")      'forward-char)
(global-set-key (kbd "\eOD")      'backward-char)
(global-set-key (kbd "<C-left>")  'windmove-left)
(global-set-key (kbd "<C-down>")  'windmove-down)
(global-set-key (kbd "<C-up>")    'windmove-up)
(global-set-key (kbd "<C-right>") 'windmove-right)

;; External packages
;; Ace Isearch
(use-package ace-isearch
  :config
  (global-ace-isearch-mode 1)
  (setq ace-isearch-jump-delay 0.5)
  (setq ace-isearch-function 'avy-goto-char)
  (setq ace-isearch-use-jump 'printing-char))
;; Auto Complete
(use-package auto-complete-config
  :config
  (ac-config-default)
  (global-auto-complete-mode 0.3))
;; Display Theme
(use-package display-theme
  :if window-system
  :config
  (display-theme-mode))
;; Dumb Jump
(use-package dumb-jump
  :config
  (dumb-jump-mode))
;; Editorconfig
(use-package editorconfig
  :config
  (editorconfig-mode 1))
;; Flycheck
(use-package flycheck
  :config
  (global-flycheck-mode))
;; Flycheck Checkbashisms
(use-package flycheck-checkbashisms
  :config
  (flycheck-checkbashisms-setup))
;; Iedit
(use-package iedit)
;; Magit
(use-package magit
  :bind ("C-c g" . magit-status))
;; Git Gutter
(use-package git-gutter
  :config
  (global-git-gutter-mode t)
  (git-gutter:linum-setup))
;; Golden Ratio
(use-package golden-ratio
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-exclude-buffer-regexp '("\\*anything" "\\*helm"))
  (setq golden-ratio-extra-commands
    '(windmove-left windmove-right windmove-down windmove-up)))
;; Helm
(use-package helm-config
  :bind ("\C-x b" . helm-mini)
  :config
  (helm-mode 1))
;; Hiwin
(use-package hiwin
  :if window-system
  :config
  (hiwin-activate)
  (set-face-background 'hiwin-face "grey70"))
;; Neotree
(use-package neotree
  :bind ("\C-o" . neotree-toggle)
  :config
  (setq neo-show-hidden-files t)
  (setq neo-smart-open t))
;; Linum
(with-eval-after-load 'linum
  (set-face-attribute 'linum nil
    :height 0.8)
  (set-variable 'linum-format "%5d "))
(global-linum-mode t)
;; ;; Nlinum -- does not work with git-gutter
;; (use-package nlinum
;;   :config
;;   (global-nlinum-mode t)
;;   (setq nlinum-format "%5d ")
;;   (set-face-attribute 'linum nil
;;     :height 0.8))
;; Polymode
(use-package polymode)
;; Recentf Ext
(use-package recentf-ext
  :bind ("C-x C-r" . recentf-open-files)
  :config
  (recentf-mode t)
  (setq recentf-max-menu-items 10)
  (setq recentf-max-saved-items 1000)
  (set-variable 'recentf-auto-save-timer
    (run-with-idle-timer 30 t 'recentf-save-list)))
;; Redo+
(use-package redo+
  :bind ("C-M-_" . redo)
  :config
  (setq undo-no-redo t)
  (setq undo-limit 100000)
  (setq undo-strong-limit 1000000))
;; Sudo Edit
(use-package sudo-edit
  :bind ("C-c C-r" . sudo-edit))

(provide 'init)
;;; init.el ends here
