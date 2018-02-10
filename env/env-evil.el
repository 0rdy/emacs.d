;; Enable evil mode
(use-package evil
  :ensure t
  :defer .1 ;; don't block emacs when starting, load evil immediately after startup
  :init
  (setq evil-want-integration nil) ;; required by evil-collection
  (setq evil-want-fine-undo t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-ex-search-vim-style-regexp t)
  (setq evil-move-beyond-eol t)
  (setq evil-shift-round nil)

  :config

  ;; (setq evil-search-module 'evil-search)
  ;; (setq evil-magic 'very-magic)
  ;; (setq evil-vim-regexp-replacements nil)
  ;; (setq evil-auto-indent nil)

  ;; Initial states
  (evil-set-initial-state 'nrepl-mode 'insert)

  ;; fix for company
  (evil-declare-change-repeat 'company-complete)

  ;; Evil ex
  (evil-ex-define-cmd "pu[pgrade]" 'package-utils-upgrade-all)
  (evil-ex-define-cmd "pi[stall]"  'package-install)
  (evil-ex-define-cmd "pd[elete]"  'package-delete)
  (evil-ex-define-cmd "lt"  'load-theme)

  (evil-mode 1))

;; Vim-like keybindings everywhere in Emacs
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-goggles
  :ensure t
  :after evil
  :config
  (defun evil-goggles--show-p (beg end)
    "Return t if the overlay should be displayed in region BEG to END."
    (and (not evil-goggles--on)
        (not evil-inhibit-operator-value)
        (bound-and-true-p evil-mode)
        (numberp beg)
        (numberp end)
        (> (- end beg) 1)
        (<= (point-min) beg end)
        (>= (point-max) end beg)
        ;; (not (evil-visual-state-p))
        (not (evil-insert-state-p))
        ;; don't show overlay when evil-mc has multiple fake cursors
        (not (and (fboundp 'evil-mc-has-cursors-p) (evil-mc-has-cursors-p)))
        ;; don't show overlay when the region has nothing but whitespace
        (not (null (string-match-p "[^ \t\n]" (buffer-substring-no-properties beg end))))))

  (setq evil-goggles-pulse t)
  (evil-goggles-mode))

(use-package evil-commentary
  :ensure t
  :after evil
  :commands (evil-commentary evil-commentary-yank))

; TODO: maps
(use-package evil-surround
  :ensure t
  :commands (global-evil-surround-mode
             evil-surround-edit
             evil-Surround-edit
             evil-surround-region)
  :config (global-evil-surround-mode 1))

;; Magit
(use-package evil-magit
  :ensure t
  :after magit)

(use-package evil-matchit
  :ensure t
  :commands (evilmi-jump-items evilmi-text-object global-evil-matchit-mode)
  :config
  (global-evil-matchit-mode t))

(use-package evil-visualstar
  :ensure t
  :commands (global-evil-visualstar-mode
             evil-visualstar/begin-search
             evil-visualstar/begin-search-forward
             evil-visualstar/begin-search-backward)
  :config
  (global-evil-visualstar-mode))

(use-package evil-lion
 :ensure t
 :commands (evil-lion-mode evil-lion-left evil-lion-right)
 :config
  (setq evil-lion-squeeze-spaces t))

;; Folding

(use-package vimish-fold
  :ensure t
  :config
  (use-package evil-vimish-fold
    :ensure t
    :config
    (add-to-list 'after-init-hook #'evil-vimish-fold-mode))
    (setq vimish-fold-header-width nil))

(use-package evil-numbers
  :commands (evil-numbers/inc-at-pt evil-numbers/dec-at-pt)
  :ensure t)


(provide 'env-evil)
