(use-package emacs-eclim
  :config
  (use-package company-emacs-eclim)
  (company-emacs-eclim-setup)
  :bind (:map eclim-mode-map
              ("C-c C-c" . eclim-maven-run))
  :init
  (custom-set-variables '(eclim-default-workspace "~/.workspace/")))

;; (use-package malabar-mode
;; 			 :init 
;; 			 (use-package groovy-mode)
;; 			 (use-package inf-groovy))
 

(add-hook 'c-mode-hook '(lambda ()
                         (setq c-basic-offset 4
                               tab-width 4
                               indent-tabs-mode nil)
						       c-default-style "java"))

(provide 'init-java)
