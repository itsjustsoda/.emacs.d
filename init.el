;; Packaging
(setq package-list '(evil evil-surround evil-numbers evil-leader
			  powerline-evil powerline column-marker
			  linum-relative))

(setq package-archives '(("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-components))

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

;; Editor
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq column-number-mode t)

(require 'linum-relative)
(global-linum-mode 1)

;; Evil >:D
(require 'evil)
(evil-mode 1)

;; Customization
(set-default-font "DejaVu Sans Mono 10")


(require 'powerline)
(powerline-default-theme)

(require 'column-marker)
(column-marker-1 80)
