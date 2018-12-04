;;; package --- Summary :
;;; Commentary:

;;; Code:

;; Just Editor Things
(setq inhibit-startup-screen t)

(menu-bar-mode -1)
(when window-system 
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(xterm-mouse-mode t)
(customize-set-variable 'mouse-sel-mode t)


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Default Formatting Options
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


(load-theme 'wombat t)
;(load-theme 'gruvbox  t)

(defmacro load-font (font)
  (when (and window-system (find-font (font-spec :name font))
	     (set-frame-font font nil t))))

(load-font "DejaVu Sans Mono 8")

;; Packaging
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)


;; CEDET
(load-file "/usr/share/emacs/site-lisp/cedet/cedet-devel-load.el")
(semantic-load-enable-code-helpers)


;; Load language options
(add-to-list 'load-path "~/.emacs.d/lang/")
(mapc 'load-library
	  (mapcar 'file-name-base 
		(file-expand-wildcards 
		  (concat user-emacs-directory "/lang/*"))))

(use-package neotree
  :config
  (setq neo-smart-open t)
  (customize-set-variable 'abbrev-mode t)
  (add-hook 'neotree-mode-hook
	    (lambda ()
	      (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
	      (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
	      (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
	      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
	      (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
	      (define-key evil-normal-state-local-map (kbd "i") 'neotree-enter-horizontal-split)
	      (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
	      (define-key evil-normal-state-local-map (kbd "o") 'neotree-create-node)
	      (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(use-package nyan-mode
  :init
  (setq nyan-wavy-trail t)
  (nyan-mode)
  (nyan-start-animation)
  :config
  (defconst +catface+ [["~:3" "~;3"] ["~^ω^" "~^.^"]]))

(use-package evil-leader
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-leader/set-leader "\\")
  (setq evil-leader/in-all-states 1)
  (evil-leader/set-key
    "x"   'helm-M-x
    "sx"  'smex
    "r"   'rainbow-delimiters-mode
    "ll"  'compile
    "n"   'linum-relative-toggle
    "TAB" 'neotree-toggle
    "g"   'magit-status))

(use-package evil
  :init 
  (setq evil-want-C-u-scroll t)
  (global-evil-leader-mode)
  :config
  (define-key evil-normal-state-map "gh"'windmove-left)
  (define-key evil-normal-state-map "gj"'windmove-up)
  (define-key evil-normal-state-map "gk"'windmove-down)
  (define-key evil-normal-state-map "gl"'windmove-right)
  (evil-mode))

(use-package evil-surround
  :init
  (global-evil-surround-mode 1))


;; (use-package ido
;;   :config
;;   (ido-mode t))

(use-package smex)


(use-package projectile
  :config
  (setq projectile-switch-open-project 'neotree-projectile-action)
  (projectile-global-mode))

(use-package helm
  :config
  (require 'helm-config)
  (setq helm-M-x-fuzzy-match t)
  (use-package helm-projectile
    :config
    (setq projectile-completion-system 'helm)
    (helm-projectile-on)))


(use-package linum-relative
  :config
  (global-linum-mode 1))

(use-package rainbow-delimiters)


(show-paren-mode 1)
(setq show-parent-delay 0)

(use-package fill-column-indicator
  :config
  (setq fci-rule-column 80)
  (setq fci-dash-pattern 0.5))

(use-package flycheck
  :init
  (use-package let-alist)
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))


(use-package irony
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package irony-eldoc
  :config
  (add-hook 'irony-mode-hook 'irony-eldoc))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  :bind ("C-x C-o" . company-complete))

(use-package company-irony
  :config
  (add-to-list 'company-backends 'company-irony)
  (add-to-list 'company-backends 'company-omnisharp))

(use-package flycheck-irony
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


(use-package auto-complete
  :config
  (ac-config-default))

(use-package sr-speedbar;
  :config
  (setq speedbar-use-images nil))

(use-package qml-mode)

(use-package ess)


(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox))

(use-package smooth-scrolling)

(use-package magit
  :config
  (use-package evil-magit))

(use-package diff-hl)

(use-package git-gutter)

(use-package paredit)
