(use-package emacs-eclim
  :config
  (use-package company-emacs-eclim)
  (company-emacs-eclim-setup)
  :init
  (custom-set-variables '(eclim-default-workspace "~/workspace/")))

(add-hook 'c-mode-hook '(lambda ()
						 (setq c-basic-offset 4)
						 (setq c-default-style "java")))

(provide 'init-c)
