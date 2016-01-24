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
(setq mouse-sel-mode t)


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Default Formatting Options
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


(load-theme 'wombat t)

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

;; Load language options
(add-to-list 'load-path "~/.emacs.d/lang/")
(mapc 'load-library
	  (mapcar 'file-name-base 
		(file-expand-wildcards 
		  (concat user-emacs-directory "/lang/*"))))

(use-package neotree
  :config
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
    "x"   'smex
    "r"   'rainbow-delimiters-mode
    "ll"  'compile
    "n"   'linum-relative-toggle
    "TAB" 'neotree-toggle))

(use-package evil
  :init 
  (setq evil-want-C-u-scroll t)
  (global-evil-leader-mode)
  :config
  (evil-mode))


(use-package ido
  :config
  (ido-mode t))

(use-package smex)

(use-package projectile
  :config
  (projectile-global-mode))


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
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-irony
  :config
  (add-to-list 'company-backends 'company-irony))

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

(use-package racket-mode
  :config
  (defconst racket--repl-command-timeout 2))
