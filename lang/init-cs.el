(use-package csharp-mode
  :mode ("\\.cs\\'" . csharp-mode))

(use-package omnisharp
  :config
  (add-hook 'csharp-mode-hook 'omnisharp-mode)
  :init
  (use-package cl)
  (custom-set-variables '(omnisharp-server-executable-path
                          "~/.omnisharp/OmniSharp/bin/Debug/OmniSharp.exe")))

(provide 'init-cs)
