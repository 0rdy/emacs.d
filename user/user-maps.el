;; general-describe-keybindings provides a list with keybinding
(with-eval-after-load 'general

  ;; TODO: add maps
  ;; load-theme
  ;; counsel-linux-app
  ;; counsel-mark-ring
  ;; counsel-imenu
  ;; counsel-descbinds
  ;; counsel-unicode-char
  ;; counsel-faces

  (general-define-key ; :keymaps '(override)
   :states '(normal insert emacs)
   :prefix snug-leader
   :non-normal-prefix snug-non-leader
   "1" '(colorpicker :wk "Color picker")
   "2" '(undo-propose :wk "Undo-tree")
   "3" 'treemacs
   "4" '(imenu-list-smart-toggle :wk "Imenu-list")
   "5" '(hydra-flyspell/body :wk "Flyspell language")
   "6" 'ivy-resume
   "k" 'counsel-ag
   "r" 'quickrun

   ;; Open things quickly
   "o r" '(counsel-recentf :wk "Recentf files")
   ;; "o f" 'counsel-file-jump
   "o f" '(counsel-fzf :wk "fzf")
   "o F" '(counsel-find-file :wk "Find files")
   "o b" '(switch-to-buffer :wk "Switch buffer")
   "o l" '(counsel-bookmark :wk "Bookmarks")
   "o y" '(counsel-yank-pop :wk "Yank ring")

   ;; Find [files]
   "f"   '(:ignore t :wk "Files")
   "f r" '(counsel-recentf :wk "Recentf files")
   "f f" '(counsel-find-file :wk "Find files")
   "f F" '(counsel-fzf :wk "fzf")

   ;; TODO: (??) "c e" "c s" for list errors(i.e. check err, syn)
   ;; "e" 'flycheck-list-errors
   ;; TODO: (??) move to lisp mode
   ;; TODO: remap "e d"
   "e e" 'eval-expression
   "e p" 'eval-print-last-sexp
   "e w" 'eval-last-sexp
   "e d" 'eval-defun
   "e b" 'eval-buffer

   ;; Olivetti
   ". ." 'olivetti-mode
   ". [" 'olivetti-shrink
   ". ]" 'olivetti-expand
   ". m" 'olivetti-toggle-hide-mode-line

   ;; TODO: add erase-buffer revert-buffer
   "b p" '(previous-buffer :wk "Previous buffer")
   "b n" '(next-buffer :wk "Next buffer")
   "b l" '(ivy-switch-buffer :wk "Switch buffer")

   ;; Help
   "h a" '(apropos :wk "Search help")
   "h k" '(describe-key :wk "Describe keybinding")
   "h K" '(general-describe-keybindings :wk "Keybinding list")
   "h v" '(describe-variable :wk "Describe varibable")
   "h f" '(describe-function :wk "Describe function")
   "h F" '(describe-face :wk "Describe face")
   "h m" '(describe-mode :wk "Describe mode")
   "h l" '(find-library :wk "Find library")
   "h i" 'info

   "h ." '(helpful-at-point :wk "Describe thing at point" :predicate (featurep 'helpful))

   ;; Window management
   "w c" '(delete-window :wk "Close split")
   "w s" '(split-window-below :wk "Split below")
   "w v" '(split-window-right :wk "Split right")
   "w d" '(kill-this-buffer :wk "Kill this buffer")
   ;; "w D" 'kill-buffer
   "w D" '(eyebrowse-close-window-config :which-key "close workspace")
   ;; "wc" '(eyebrowse-create-window-config :which-key "create workspace")
   ;; "wn" '(eyebrowse-next-window-config :which-key "next workspace")
   ;; "wp" '(eyebrowse-prev-window-config :which-key "prev workspace")

   "w w" 'evil-window-next
   "w h" 'evil-window-left
   "w j" 'evil-window-down
   "w k" 'evil-window-up
   "w l" 'evil-window-right

   "w H" 'evil-window-move-far-left
   "w J" 'evil-window-move-far-down
   "w K" 'evil-window-move-far-up
   "w L" 'evil-window-move-far-right

   "w m" 'minimize-window
   "w M" 'maximize-window

   "w u" '(winner-undo :which-key "winner undo")
   "w r" '(winner-redo :which-key "winner redo")

   ;; Git/Magit
   "g b" 'magit-blame
   "g d" 'magit-diff
   "g s" 'magit-status
   "g S" 'git-gutter:stage-hunk
   "g r" 'git-gutter:revert-hunk
   "g R" 'magit-revert
   "g l" 'magit-log-current
   "g f" 'magit-log-buffer-file
   "g ]" 'git-gutter:next-hunk
   "g [" 'git-gutter:previous-hunk

   ;; Projectile
   "p p" '(projectile-switch-project :wk "Switch project")
   "p f" '(counsel-projectile-find-file :wk "Find file in project")
   "p k" '(projectile-ag :wk "Grep in project")
   "p r" '(projectile-replace :wk "Replace in project")
   "p t" '(projectile-regenerate-tags :wk "Update tags for project"))

  (general-define-key
   :keymaps '(normal visual)
   :prefix snug-leader
   "t"   'google-translate-smooth-translate
   ;; Narrowing
   "n r" 'narrow-to-region
   "n d" 'narrow-to-defun
   "n p" 'narrow-to-page
   "n w" 'widen

   ;; Insert
   "i y" 'counsel-yank-pop
   "i s" 'yas-insert-snippet
   )

  ;; Normal state
  (general-define-key
   :states '(normal)
   "C-0" '(lambda () (interactive) (text-scale-set 0))
   "C--" 'text-scale-increase
   "C-_" 'text-scale-decrease
   "*" '(lambda () (interactive) (swiper (format "\\<%s\\>" (thing-at-point 'symbol))))
   "#" '(lambda () (interactive) (swiper (format "\\<%s\\>" (thing-at-point 'word))))
   )

  ;; nvmap
  (general-define-key
   :keymaps '(normal visual)
   "g x"  'browse-url-at-point
   "/"    'swiper
   ;; Navigation between windows
   "M-h"  'evil-window-left
   "M-j"  'evil-window-down
   "M-k"  'evil-window-up
   "M-l"  'evil-window-right

   "M-x"  'counsel-M-x
   ;; Drag stuff
   "C-h"  'drag-stuff-left
   "C-j"  'drag-stuff-down
   "C-k"  'drag-stuff-up
   "C-l"  'drag-stuff-right

   ;; evil-commentary
   "g c" 'evil-commentary
   "g y" 'evil-commentary-yank
   "g p" 'snug/evil-select-pasted

   ;; evil-lion
   "g a"  'evil-lion-left
   "g A"  'evil-lion-right

   "j"   'evil-next-visual-line
   "k"   'evil-previous-visual-line
   "C-a" 'evil-numbers/inc-at-pt
   "C-x" 'evil-numbers/dec-at-pt

   ;; git-gutter
   "] h" 'git-gutter:next-hunk
   "[ h" 'git-gutter:previous-hunk)

  ;; Bind ESC to jk in insert mode
  (general-define-key
   :keymaps '(insert)
   "j" (general-key-dispatch 'self-insert-command
         :name gl/evil-escape
         :timeout 0.25
         "k" 'evil-normal-state))

  ;; Use snug newline-and-indent function
  (general-define-key
   :keymaps 'prog-mode-map
   :states '(insert)
   "RET" 'snug/newline-and-indent)

  (general-define-key
   :keymaps 'company-search-map
   "C-n"    #'company-search-repeat-forward
   "C-p"    #'company-search-repeat-backward
   "C-s"    '(lambda () (interactive) (company-search-abort) (company-filter-candidates))
   [escape] #'company-search-abort)


  ;; Insert mode maps
  (general-define-key
   :states '(insert)
   "TAB" 'company-indent-or-complete-common
   ;; "TAB" 'company-indent-for-tab-command
   "M-DEL" 'snug/smart-backspace
   "C-v" 'clipboard-yank
   ;; "C-k" 'company-complete-common-or-cycle
   "C-a" 'beginning-of-line
   "C-w" 'evil-delete-backward-word
   "C-e" 'end-of-line)

  ;; Dired
  (general-define-key :keymaps 'dired-mode-map
                      :states '(normal)
                      "h" 'dired-up-directory
                      "l" 'dired-find-alternate-file
                      "o" 'dired-sort-toggle-or-edit
                      "v" 'dired-toggle-marks
                      "m" 'dired-mark
                      "u" 'dired-unmark
                      "U" 'dired-unmark-all-marks
                      "c" 'dired-create-directory
                      ;; "n" 'evil-search-next
                      ;; "N" 'evil-search-previous
                      "q" 'kill-this-buffer)


  ;; Lisp modes
  (general-define-key :keymaps 'clojure-mode-map
                      :prefix snug-leader
                      :states '(normal visual)
                      "e w" 'cider-eval-sexp-at-point
                      "e e" 'cider-eval-defun-at-point
                      "e r" 'cider-eval-last-sexp-to-repl
                      "e b" 'cider-eval-buffer
                      "e x" 'cider-eval-last-sexp-and-replace)

  (general-define-key :keymaps 'clojure-mode-map
                      :prefix snug-leader
                      :states '(visual)
                      "e e" 'cider-eval-region)

  (general-define-key :keymaps 'emacs-lisp-mode-map
                      :prefix snug-leader
                      :states '(visual)
                      "e r" 'eval-region)

  ;; (general-define-key :keymaps '(python-mode-map nim-mode-map haskell-mode-map)
  ;;                     :states '(insert)
  ;;                     "RET" 'evil-ret-and-indent)

  ;; Flycheck
  (general-define-key :keymaps 'flycheck-mode-map
                      :states '(normal)
                      "] e" 'flycheck-next-error
                      "[ e" 'flycheck-previous-error)


  ;; EShell
  ;; (general-define-key :keymaps 'eshell-mode-map
  ;;                     :states  '(insert)
  ;;                     "RET" 'eshell-send-input)

  ;; Term-mode
  ;; TODO:
  ;; (general-define-key :keymaps 'term-mode-map
  ;;                     :states  '(insert)
  ;;                     "RET" 'term-send-input)

  ;; Org-mode
  (general-define-key :keymaps 'org-mode-map
                      :states  '(normal visual)
                      "M-h"  'evil-window-left
                      "M-j"  'evil-window-down
                      "M-k"  'evil-window-up
                      "M-l"  'evil-window-right)

  ;; Evil-surround
  (general-define-key :keymaps '(operator)
                      "s" 'evil-surround-edit
                      "S" 'evil-Surround-edit)

  ;; Visual state maps
  (general-define-key :keymaps '(visual)
                      "*"  'evil-visualstar/begin-search-forward
                      "#"  'evil-visualstar/begin-search-backward
                      "S"  'evil-surround-region
                      "gS" 'evil-Surround-region)

  (general-define-key :keymaps '(haskell-mode-map)
                      :states '(insert)
                      "TAB"  'company-indent-or-complete-common)

  (general-define-key :keymaps 'ivy-minibuffer-map
                      "C-SPC"  'ivy-call-and-recenter
                      "C-r"    'evil-paste-from-register
                      "C-k"    'ivy-previous-line
                      "C-j"    'ivy-next-line
                      "C-l"    'ivy-alt-done
                      "C-w"    'ivy-backward-kill-word
                      "C-u"    'ivy-kill-line
                      "C-f"    'forward-word
                      "C-b"    'backward-word)

  ;; TODO:
  ;; (general-omap
  ;;   :prefix "SPC"
  ;;   "." 'avy-goto-word-or-subword-1
  ;;   "l" 'evil-avy-goto-line
  ;;   "e" 'evil-avy-goto-subword-0 )

  ;; Company maps
  (general-define-key
   :keymaps 'company-active-map
   "C-w"        nil
   "C-h"        'company-quickhelp-manual-begin
   "C-n"        'company-select-next
   "C-o"        'company-search-kill-others
   "C-p"        'company-select-previous
   "C-s"        'company-filter-candidates
   "C-S-h"      'company-show-doc-buffer
   "C-S-s"      'company-search-candidates
   "C-SPC"      'company-complete-common
   "RET"        'company-complete-selection
   [return]     'company-complete-selection
   [tab]        'company-complete-common-or-cycle
   [backtab]    'company-select-previous)

  ;; Fix TAB in terminal
  (general-define-key
   :keymaps 'input-decode-map
   ;; :predicate '(not (window-system))
   "TAB" '([tab] :predicate '(not (window-system))))

  )

(provide 'user-maps)
