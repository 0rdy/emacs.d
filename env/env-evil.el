;;; Evil mode -*- lexical-binding: t -*-
;; TODO: (??)  shift-select-mode set to nil
(use-package evil
  :init
  (setq evil-want-integration t ;; required by evil-collection
        evil-want-keybinding nil
        evil-want-fine-undo t
        evil-want-Y-yank-to-eol t
        evil-ex-search-vim-style-regexp t
        evil-want-C-u-scroll t
        ;; evil-ex-search-persistent-highlight nil

        evil-visual-state-cursor 'hollow
        evil-mode-line-format 'nil

        evil-ex-search-case 'smart
        evil-ex-substitute-case t
        evil-move-beyond-eol t
        evil-shift-round nil
        ;; more vim-like behavior
        evil-symbol-word-search t
        evil-insert-skip-empty-lines t

        evil-magic t
        ;; evil-magic 'very-magic
        ;; evil-vim-regexp-replacements nil

        ;; evil-auto-indent nil
        evil-indent-convert-tabs t)

  :config

  (evil-select-search-module 'evil-search-module 'evil-search)
  (add-hook 'evil-insert-state-entry-hook #'evil-ex-nohighlight)

  (defun evil-clear-hl-after-search ()
    (when evil-ex-active-highlights-alist
      (unless (memq last-command '(evil-search-next
                                   evil-search-previous
                                   evil-ex-search-next
                                   evil-ex-search-previous))
        (evil-ex-nohighlight))))

  (add-hook 'post-command-hook #'evil-clear-hl-after-search)

  ;; Initial states
  (evil-set-initial-state 'nrepl-mode 'insert)

  ;; Evil ex commands
  (evil-ex-define-cmd "pu[pgrade]" 'package-upgrade-all)
  (evil-ex-define-cmd "pi[stall]"  'package-install)
  (evil-ex-define-cmd "pf[orce]"   'package-reinstall)
  (evil-ex-define-cmd "pd[elete]"  'package-delete)
  (evil-ex-define-cmd "pc[lean]"   'package-autoremove)
  (evil-ex-define-cmd "lt"         'load-theme)

  (with-eval-after-load 'evil
    (evil-add-command-properties #'find-file-at-point :jump t)
    (evil-add-command-properties #'counsel-rg :jump t)
    (evil-add-command-properties #'counsel-fzf :jump t))

  (evil-mode 1))

;; Vim-like keybindings everywhere in Emacs
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-goggles
  :after evil
  :hook (after-init . evil-goggles-mode)
  :config
  (setq evil-goggles-duration 0.1
        evil-goggles-enable-delete nil
        evil-goggles-pulse t))


(use-package evil-commentary
  :after evil
  :commands (evil-commentary evil-commentary-yank))

;; TODO: maps
(use-package evil-surround
  :after evil
  :commands (global-evil-surround-mode
             evil-surround-edit
             evil-Surround-edit
             evil-surround-region)
  :config (global-evil-surround-mode 1))

;; Magit
(use-package evil-magit
  :after evil magit)

(use-package evil-matchit
  :after evil
  ;; :commands (evilmi-jump-items evilmi-text-object global-evil-matchit-mode)
  :config
  (global-evil-matchit-mode t))

(use-package evil-visualstar
  :commands (global-evil-visualstar-mode
             evil-visualstar/begin-search
             evil-visualstar/begin-search-forward
             evil-visualstar/begin-search-backward)
  :config
  (global-evil-visualstar-mode))

(use-package evil-lion
  :after evil
  :commands (evil-lion-mode evil-lion-left evil-lion-right)
  :config (setq evil-lion-squeeze-spaces t))

;; Folding
;; TODO: maps
(use-package evil-vimish-fold
  :after evil
  :disabled t
  :hook (after-init . evil-vimish-fold-mode)
  :commands evil-vimish-fold-mode
  :config
  (setq vimish-fold-header-width nil))

(use-package evil-numbers
  :after evil
  :commands (evil-numbers/inc-at-pt evil-numbers/dec-at-pt))

(use-package evil-args
  :after evil
  :commands (evil-inner-arg evil-outer-arg
                            evil-forward-arg evil-backward-arg
                            evil-jump-out-args)
  :general
  (general-itomap "a" 'evil-inner-arg)
  (general-otomap "a" 'evil-outer-arg))

(use-package evil-embrace
  :after evil-surround
  :config
  (add-hook 'LaTeX-mode-hook #'embrace-LaTeX-mode-hook)
  (add-hook 'org-mode-hook 'embrace-org-mode-hook)
  (setq evil-embrace-show-help-p nil)
  (evil-embrace-enable-evil-surround-integration))

(provide 'env-evil)
