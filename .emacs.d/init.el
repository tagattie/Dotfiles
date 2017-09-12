;; -*- Mode: Emacs-Lisp -*-

;; Setup file for Emacs
;; .emacs

;; Language environment and character codes
(set-locale-environment nil)
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)

;; Package manager
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; Auto complete
(require 'auto-complete-config)
(global-auto-complete-mode 0.5)

;; Theme
(load-theme 'material-light t)

;; Fontset
(if window-system
    (progn
      ;;(set-frame-font "Noto Mono-10")
      (set-face-attribute 'default nil
                          :family "Noto Sans Mono"
                          :height 100)
      (set-fontset-font (frame-parameter nil 'font)
                        'katakana-jisx0201
                        (font-spec :family "Noto Sans Mono CJK JP"))
      (set-fontset-font (frame-parameter nil 'font)
                        'japanese-jisx0208
                        (font-spec :family "Noto Sans CJK JP")))
  ;;(modify-all-frames-parameters (list (assq 'font (frame-parameters))))
  )

;; Default window properties
(if window-system
    (progn
      (setq default-frame-alist
            (append (list
                     '(width . 80)
                     '(height . 40)
;;                     '(alpha . (0.95 0.90))
                     )
                    default-frame-alist))
      (setq initial-frame-alist default-frame-alist)))

;; Darken non-active window
(if window-system
    (progn
      (require 'hiwin)
      (hiwin-activate)
      (set-face-background 'hiwin-face "grey70")))

;; Change windows background color for root user
(if window-system
    (if (equal user-real-login-name "root")
        (set-background-color "LemonChiffon")))

;; Swap backspace and delete
(if window-system
    (progn
      (define-key function-key-map [delete] [8])
      (put 'delete 'ascii-character 8))
  (load-library "term/bobcat"))

;; Show menu only when emacs on window, not on terminal
(if window-system
    (menu-bar-mode 1)
  (menu-bar-mode -1))


;;;; Misc. settings
;; Don't show startup message
(setq inhibit-startup-message t)
;; Don't show initial scratch message
(setq initial-scratch-message "")
;; Show full path for window title
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))
;; Don't show toolbar
(tool-bar-mode -1)
;; Don't show scrollbar
(scroll-bar-mode -1)
;; Show line & column number
(require 'linum)
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#006600"
                    :height 0.8)
(line-number-mode t)
(column-number-mode t)
;; No line spacing
(setq-default line-spacing 0)
;; Highlight matched parenthesess
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "#AABBFF")
(set-face-foreground 'show-paren-match-face "#000000")
;; Highlight current line
(global-hl-line-mode t)
;; Highlight active region
(transient-mark-mode 1)
;; Show whitespace characters
(require 'whitespace)
(setq whitespace-style
      '(face
        trailing
        tabs
;;        empty     ; Empty lines at SOF/EOF
        space-mark
        tab-mark))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
(setq-default show-trailing-whitespace t)
(global-whitespace-mode 1)
(set-face-background 'trailing-whitespace "#b14770")
(set-face-attribute 'whitespace-trailing nil
                    :background "#b14770"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :foreground "SkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :foreground "GreenYellow"
                    :underline t)
;; Use space character for indent (width is 4)
;; (setq-default indent-tabs-mode nil
;;               tab-width 4)
;; -> Moved to editorconfig
;; Show newline code (CR, CRLF, LF)
(setq eol-mnemonic-unix "(LF)")
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
;; Scroll vertically a line at a time
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t)
;; Blink cursor 1 time / second
(setq blink-cursor-interval 1)
;; Show information on function/variable... at current point
(which-function-mode 1)
;; Show date/time on mode line
(display-time-mode t)
(setq display-time-string-forms
      '((format "%s/%s/%s(%s)%s:%s"
                year month day dayname 24-hours minutes)))
;; Insert at current point (not at click point)
(setq mouse-yank-at-point t)
;; Don't auto add new lines at the end
(setq next-line-add-newlines nil)
;; Don't kill LF when killin a whole line
(setq kill-whole-line nil)
;; Set garbage collection frequency
(setq gc-cons-threshold 1000000)
;; Set maximum eval'able depth without error
(setq max-lisp-eval-depth 1000000)
;; Make "yes or no" "y or n"
(fset 'yes-or-no-p 'y-or-n-p)
;; Show recent files in Menu
(recentf-mode t)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 1000)
;; Save mini buffer history
(savehist-mode 1)
(setq history-length 1000)

;; EditorConfig
(require 'editorconfig)
(editorconfig-mode 1)
;; Anything
(require 'anything-startup)
;; Dired-x
(require 'dired-x)
;; Elscreen
;; (require 'elscreen)
;; (elscreen-start)
;; make \C-z as a prefix conflicts with my key bindings
;; Neotree
(require 'neotree)
(global-set-key "\C-o" 'neotree-toggle)
;; Golden Ratio
(golden-ratio-mode 1)
;; Saveplace
(require 'saveplace)
(setq-default save-place t)
;; Multi-term
(require 'multi-term)
(setq multi-term-program "/usr/local/bin/zsh")
;; Git
(require 'magit)
(global-set-key (kbd "C-c C-g") 'magit-diff-working-tree)
(global-git-gutter-mode 1)
(global-auto-revert-mode 1)
;; Mozc
(setq default-input-method "japanese-mozc")


;; Key bindings
(global-set-key "\C-x\C-z" 'suspend-emacs)
(global-set-key "\C-z" 'scroll-down)
(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\C-xi" 'insert-file)
(global-set-key "\C-xs" 'isearch-forward)
(global-set-key "\M-\C-r" 'query-replace-regexp)
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-l" 'goto-line)
(global-set-key "\eOA" 'previous-line)
(global-set-key "\eOB" 'next-line)
(global-set-key "\eOC" 'forward-char)
(global-set-key "\eOD" 'backward-char)
;; (global-set-key "\C-x\C-m" 'compile)
;; (global-set-key "\C-xw" 'what-line)

;; Anthy
;;(load-library "anthy")
;;(setq default-input-method "japanese-anthy")

(custom-set-variables
    ;; custom-set-variables was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
    '(package-selected-packages
         (quote
             (neotree anything multi-term editorconfig go-mode groovy-mode material-theme hiwin golden-ratio git-gutter dash auto-complete async))))
(custom-set-faces
    ;; custom-set-faces was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
    )
