;; Haskell -*- lexical-binding: t -*-
(use-package haskell-mode
  :mode ("\\.hs\\'" . haskell-mode)
  :config
  (add-hook 'haskell-mode-hook (lambda () (setq-local electric-indent-inhibit t))))

(use-package flycheck-haskell
  :defer t
  :hook (haskell-mode . flycheck-haskell-setup))

(use-package dante
  :after haskell-mode
  :disabled t
  :commands (dante-mode)
  :hook (haskell-mode . dante-mode))

(provide 'use-haskell)
