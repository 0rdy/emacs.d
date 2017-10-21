;; Enable evil mode
(use-package evil
  :config
  (setq evil-want-fine-undo nil)

  ;; (setq evil-search-module 'evil-search)
  ;; (setq evil-magic 'very-magic)
  ;; (setq evil-vim-regexp-replacements nil)
  (setq evil-ex-search-vim-style-regexp t)
  (setq evil-move-beyond-eol t)
  ;; (setq evil-auto-indent nil)

  ;; Initial states
  (evil-set-initial-state 'nrepl-mode 'insert)

  ;; fix for company
  (evil-declare-change-repeat 'company-complete)

  ;; Evil ex
  (evil-ex-define-cmd "pu[pgrade]" 'package-utils-upgrade-all)
  (evil-ex-define-cmd "pi[stall]"  'package-install)
  (evil-ex-define-cmd "pd[elete]"  'package-delete)

  (evil-mode 1))

(use-package evil-goggles
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

  (evil-goggles-mode)
  (setq evil-goggles-pulse t))

(use-package evil-commentary
  :after evil
  :commands (evil-commentary evil-commentary-yank)
  :general
  (general-nvmap
   "gc" 'evil-commentary
   "gy" 'evil-commentary-yank))

(use-package evil-surround
  :init
  (global-evil-surround-mode 1))

;; Magit
(use-package evil-magit
  :after magit)

(use-package evil-matchit
  :config
  (global-evil-matchit-mode t))

(use-package evil-visualstar
  :config
  (global-evil-visualstar-mode))

(use-package evil-lion
  :commands (evil-lion-mode evil-lion-left evil-lion-right)
  :config
  (setq evil-lion-squeeze-spaces t)
  :general
  (general-nvmap
   "ga"  'evil-lion-left
   "gA"  'evil-lion-right))

;; Folding

(use-package vimish-fold
  :config
  (use-package evil-vimish-fold
    :init
    (evil-vimish-fold-mode 1))
  (setq vimish-fold-header-width nil))

(use-package evil-numbers)


(provide 'env-evil)
