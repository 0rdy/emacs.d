(use-package haskell-mode
  :mode ("\\.hs\\'" . haskell-mode)
  :config
  (add-hook 'haskell-mode-hook (lambda () (setq-local electric-indent-inhibit t))))

(use-package dante
  :after haskell-mode
  :disabled t
  :commands (dante-mode)
  :config
  (add-hook 'haskell-mode-hook 'dante-mode))

(provide 'use-haskell)
