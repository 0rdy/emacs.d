;; TODO: split to basic plugin and dev plugin
(use-package package-utils
  :ensure t
  :commands (package-utils-upgrade-all))

;; smart new line
;; (use-package smart-newline
;;   :init
;;   (add-hook 'prog-mode-hook 'smart-newline-mode))

;; Auto-indent-mode
;; (use-package auto-indent-mode
;;   :init
;;   ;; (add-hook 'prog-mode-hook 'auto-indent-mode)
;;   (setq auto-indent-on-visit-file t)
;;   (auto-indent-global-mode)
;;   :config
;;   (setq auto-indent-newline-function 'newline-and-indent)
;;   (add-to-list 'auto-indent-multiple-indent-modes 'nim-mode))

;; Electric indent
;; (electric-indent-mode -1)
(setq-default electric-indent-inhibit t)

;; Undotree
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  ;; Persistent undo-tree history across emacs sessions
  (setq undo-tree-history-directory-alist '(("." . "~/.cache/emacs/undo")))
  (add-hook 'write-file-functions #'undo-tree-save-history-hook)
  (add-hook 'find-file-hook #'undo-tree-load-history-hook)
  (add-hook 'find-file-hook #'global-undo-tree-mode-check-buffers)

  (setq undo-tree-visualizer-timestamps t))
;; (setq undo-tree-visualizer-diff t))

;; Recent files
;; TODO: auto cleanup
;; see: https://gist.github.com/masutaka/1325654/955277113028eb7b968453a5b7802b74b51b393d
;; TODO: disable message in minibuffer after auto-save
(use-package recentf
  :init
  ;; Save recentf every 5 minutes
  (run-at-time nil (* 5 60) 'recentf-save-list)
  ;; Recentf blacklist
  (setq recentf-exclude '("^/var/folders\\.*"
                          "COMMIT_EDITMSG\\'"
                          ".*-autoloads\\.el\\'"
                          "[/\\]\\.emacs.d/recentf"
                          "[/\\]\\.emacs.d/bookmarks"
                          "[/\\]\\.emacs.d/url"
                          "[/\\]\\.elpa/"))
  (recentf-mode 1)
  :config
  (setq recentf-auto-cleanup 2)
  (setq recentf-max-menu-items 100)
  (setq recentf-max-saved-items 50))

;; OCaml
;; (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
;;   (when (and opam-share (file-directory-p opam-share))
;;     (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
;;     (autoload 'merlin-mode "merlin" nil t nil)
;;     (add-hook 'tuareg-mode-hook 'merlin-mode t)
;;     (add-hook 'caml-mode-hook 'merlin-mode t)))

;; Project management
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

;; Quickrun
(use-package quickrun
  :ensure t
  :commands (quickrun
             quickrun-region
             quickrun-with-arg
             quickrun-shell
             quickrun-compile-only
             quickrun-replace-region))

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config (setq markdown-command "multimarkdown"))


;; Integration with Chrome/Chromium
; (use-package atomic-chrome
;   :config
;   (atomic-chrome-start-server))


;; Move region or line
(use-package drag-stuff
  :ensure t
  :commands (drag-stuff-left drag-stuff-up drag-stuff-down drag-stuff-right))
  ;; :config (drag-stuff-global-mode 1))

;; Yasnippet
;; TODO:
;; (use-package yasnippet
;;   :ensure t
;;   :config
;;   (yas-global-mode 1))

;; (use-package neotree
;;   :config
;;   (setq neo-mode-line-type 'none)
;;   :general
;;   (general-define-key :keymaps 'neotree-mode-map
;;                       :states '(normal)
;;                       "SPC" 'neotree-enter
;;                       "TAB" 'neotree-enter
;;                       "RET" 'neotree-enter
;;                       "q" 'neotree-hide))

(use-package treemacs
  :ensure t
  :commands (treemacs-toggle)
  :config
  (use-package treemacs-evil
    :after treemacs)

  ;; Disable mode-line in treemacs buffer
  ;; see: https://github.com/Alexander-Miller/treemacs/blob/d5456233909a4f558d24056a5e53f15e9f2029f6/treemacs-mode.el#L202
  (defun treemacs--setup-mode-line ()
      (setq mode-line-format nil))

  :general
  (general-define-key :keymaps 'treemacs-mode-map
                      :states  '(normal visual treemacs)
                      "M-h"  'evil-window-left
                      "M-j"  'evil-window-down
                      "M-k"  'evil-window-up
                      "M-l"  'evil-window-right))

(use-package colorpicker
  :load-path "dev/emacs-colorpicker"
  :commands (colorpicker))

;; (use-package which-key
;;   :init
;;   (which-key-mode)
;;   (which-key-setup-side-window-bottom))

;; Simple Emacs minor mode for a nice writing environment.
(use-package olivetti
  :ensure t
  :commands (olivetti-mode olivetti-shrink olivetti-expand olivetti-toggle-hide-mode-line)
  :config
  (setq-default olivetti-body-width 80))

(use-package google-translate
  :ensure t
  :defer t
  :config
  (use-package google-translate-smooth-ui
    :after google-translate
    :commands google-translate-smooth-translate)
  (setq google-translate-translation-directions-alist '(("en" . "ru"))))

(use-package imenu-list
  :ensure t
  :commands (imenu-list-smart-toggle)
  :config
  (setq imenu-list-mode-line-format nil)
  (setq imenu-list-size 32))

;; (use-package helpful
;;   :ensure t
;;   :general
;;   (general-define-key :states 'normal
;;                       :prefix leader
;;                       "h k" 'helpful-key
;;                       "h v" 'helpful-variable
;;                       ;; "h f" 'helpful-function
;;                       "h f" 'helpful-callable
;;                       "h l" 'find-library
;;                       "h ." 'helpful-at-point))

(provide 'env-plugins)
