(add-hook 'cpp-mode-hook '(lambda ()
						   (setq c-basic-offset 4)
						   (setq c-default-style "java")
						   (setq tab-width 4)
						   (setq c-basic-offset 4)
						   (setq fci-rule-column 80)
						   (show-paren-mode 1)))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(provide 'init-cpp)
