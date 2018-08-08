(use-package lsp-mode
  :disabled t
  :config
  ;; (add-hook 'prog-major-mode #'lsp-prog-major-mode-enable)

  ;; Make sure we have lsp-imenu everywhere we have LSP
  (use-package lsp-imenu
    :config
    (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

  (use-package lsp-ui
    :config
    (setq lsp-ui-sideline-ignore-duplicate t)
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)))


;; languages
(use-package lsp-html
  :disabled t
  :init
  (add-hook 'html-mode-hook #'lsp-html-enable)
  (add-hook 'web-mode-hook #'lsp-html-enable))

(use-package lsp-css
  :disabled t
  :init
  (add-hook 'css-mode-hook #'lsp-css-enable)
  (add-hook 'less-mode-hook #'lsp-less-enable)
  (add-hook 'sass-mode-hook #'lsp-scss-enable)
  (add-hook 'scss-mode-hook #'lsp-scss-enable))

(provide 'completion-lsp)
