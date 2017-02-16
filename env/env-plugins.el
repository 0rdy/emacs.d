(use-package package-utils
  :ensure t
  :commands (package-utils-upgrade-all))

;; smart new line
(use-package smart-newline
  :bind ("RET" . smart-newline))

;; Undotree
(use-package undo-tree
  :config
  (setq undo-tree-auto-save-history t)
  ;; Persistent undo-tree history across emacs sessions
  (setq undo-tree-history-directory-alist '(("." . "~/.cache/emacs/undo")))
  (add-hook 'write-file-functions #'undo-tree-save-history-hook)
  (add-hook 'find-file-hook #'undo-tree-load-history-hook)
  (add-hook 'find-file-hook #'global-undo-tree-mode-check-buffers)

  (global-undo-tree-mode 1)
  (setq undo-tree-visualizer-timestamps t))
  ;; (setq undo-tree-visualizer-diff t))

;; Recent files
(use-package recentf
  :init
  (setq recentf-exclude '("^/var/folders\\.*"
                          "COMMIT_EDITMSG\\'"
                          ".*-autoloads\\.el\\'"
                          "[/\\]\\.elpa/"))
  :config
  (setq recentf-max-menu-items 30)
  (recentf-mode 1))

;; OCaml
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)))

;; Project management
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode 1))

(use-package counsel-projectile
  :after projectile
  :config
  (counsel-projectile-on))

;; Quickrun
(use-package quickrun
  :commands (quickrun
             quickrun-region
             quickrun-with-arg
             quickrun-shell
             quickrun-compile-only
             quickrun-replace-region))

;; Markdown
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Let's simplify the way we write Lisp
(use-package parinfer
  :ensure t
  :init
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
            pretty-parens  ; different paren styles for different modes.
            evil           ; If you use Evil.
            smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
            smart-yank))   ; Yank behavior depend on mode.
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    (add-hook 'scheme-mode-hook #'parinfer-mode)
    (add-hook 'lisp-mode-hook #'parinfer-mode)))

;; Integration with Chrome/Chromium
(use-package atomic-chrome
  :config
  (atomic-chrome-start-server))

;; Move region or line
(use-package drag-stuff
  :config
  (drag-stuff-define-keys)
  (drag-stuff-global-mode 1))

;; Yasnippet
(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package neotree
  :general
  (general-define-key :keymaps 'neotree-mode-map
                      :states '(normal)
                      "SPC" 'neotree-enter
                      "TAB" 'neotree-enter
                      "RET" 'neotree-enter
                      "q" 'neotree-hide))

(provide 'env-plugins)
