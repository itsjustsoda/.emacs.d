(use-package js2-mode
  :mode ("\\.js\\'" . js2-mode)
  :init (setq js2-global-externs '("m")))

(provide 'init-js)

