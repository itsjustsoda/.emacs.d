;; Editor
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)

(load-theme 'wombat t)

;; Backups
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

;; Packaging
(setq package-list '(evil
		     evil-surround
		     evil-numbers
		     evil-leader
		     evil-visualstar
		     magit
		     git-gutter-fringe+
		     column-marker
		     relative-line-numbers
		     rainbow-delimiters
		     color-theme-approximate
		     nyan-mode))

(setq package-archives '(("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; El-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;; el-get Recipies
(el-get-bundle powerline
  :url "https://github.com/Dewdrops/powerline.git"
  :features powerline)

;; Evil >:D
(require 'evil-leader)
(evil-leader/set-leader "\\" )
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)

(require 'evil)
(evil-mode 1)

(require 'evil-visualstar)
(global-evil-visualstar-mode)

(require 'evil-surround)
(global-evil-surround-mode 1)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)


;; Editor
(require 'magit)
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(require 'nyan-mode)
(defconst +catface+ [["~:3" "~;3"] ["~^ω^" "~^ω^"]])
(setq nyan-wavy-trail t)
(nyan-start-animation)

(require 'powerline)
(powerline-center-evil-theme)

(setq relative-line-numbers-mode t)
(setq column-number-mode t)
(setq line-number-mode t)

(setq default-truncate-lines t)

(require 'git-gutter-fringe+)
(git-gutter-fr+-minimal)

;; Theming

;; Parens
(set-default-font "DejaVu Sans Mono 10")

(require 'paren)
(set-face-foreground 'show-paren-match "yellow")
(set-face-background 'show-paren-match nil)

(setq show-paren-delay 0)
(show-paren-mode 1)

(require 'linum-relative)
(global-linum-mode 1)
(setq linum-format "%4d\u2502")

(global-hl-line-mode t)
(set-face-foreground 'highlight nil)
(set-face-background 'hl-line "gray10")
(set-face-underline 'hl-line nil)

(color-theme-approximate-on)

(require 'column-marker)
(column-marker-1 80)

(require 'rainbow-delimiters)
