;; TODO:
;; (setq x-stretch-cursor t)

;; Encoding
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8
      locale-coding-system 'utf-8)

;; Disable wrote file message
(setq save-silently t)

;; Replace the region while insert
(delete-selection-mode 1)

(setq yank-pop-change-selection t)

;; Disable key bindging suggeestions
(setq suggest-key-bindings nil)

;; Enable system clipboard in terminal Emacs
;; See: https://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
;; (setq select-enable-clipboard t)

;; (unless window-system
;;   (when (getenv "DISPLAY")
;;     ;; Callback for when user cuts
;;     (defun xsel-cut-function (text &optional push)
;;       ;; Insert text to temp-buffer, and "send" content to xsel stdin
;;       (with-temp-buffer
;;         (insert text)
;;         (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
;;     ;; Call back for when user pastes
;;     (defun xsel-paste-function()
;;       (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
;;         (unless (string= (car kill-ring) xsel-output)
;;           xsel-output)))
;;     ;; Attach callbacks to hooks
;;     (setq interprogram-cut-function 'xsel-cut-function)
;;     (setq interprogram-paste-function 'xsel-paste-function)))


(setq use-dialog-box nil)

;; Replacing yes/no with y/n.
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default indicate-buffer-boundaries nil)  ; don't show where buffer starts/ends

(setq-default sentence-end-double-space nil)

;; reduce point movement lag, see https://emacs.stackexchange.com/questions/28736/emacs-pointcursor-movement-lag/28746
(setq auto-window-vscroll nil)

;; Indentation
(setq tab-width 2)
(setq evil-shift-width 2)

(setq-default indent-tabs-mode nil)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
;; (setq backward-delete-char-untabify-method 'hungry)

;; http://stackoverflow.com/questions/354490/preventing-automatic-change-of-default-directory
;; (add-hook 'find-file-hook
;;           (lambda ()
;;             (setq default-directory command-line-default-directory)))

(defun lisp-indent-setup ()
  ;; Set tab-width to 2
  (setq-local tab-width 2)
  ;; Set evil-shift-width to 2
  (setq-local evil-shift-width 2))

(add-hook 'emacs-lisp-mode-hook 'lisp-indent-setup)
(add-hook 'clojure-mode-hook 'lisp-indent-setup)

;; Clean whitespace
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Auto reload buffer if file was changed
(global-auto-revert-mode)

;; Lines
(setq indicate-empty-lines t
      require-final-newline t)

;; Disable bell
(setq visible-bell nil
      ring-bell-function 'ignore)

;; Truncate lines
(setq-default truncate-lines t)

;; TODO:
;; (setq-default global-visual-line-mode t)

;; VC settings
(setq vc-follow-symlinks t)
;; (remove-hook 'find-file-hooks 'vc-find-file-hook)
;; (setq vc-handled-backends nil)

;; Save last position
(save-place-mode 1)

;; Disable lockfiles
(setq create-lockfiles nil)

;; TODO: read
;; (setq auto-save-list-file-name nil)

;; Save history
(use-package savehist
  :config
  (savehist-mode t)
  :config
  (setq savehist-autosave-interval 60
        history-delete-duplicates t
        history-length 1000
        savehist-save-minibuffer-history t
        savehist-additional-variables '(search-ring
                                        kill-ring
                                        set-variable-value-history
                                        shell-command-history
                                        file-name-history
                                        regexp-search-ring)))

;; Backup settings
(setq backup-by-copying t      ; don't clobber symlinks
      backup-by-copying-when-linked t
      backup-directory-alist '(("." . "~/.cache/emacs/backup"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;; Autosave
(setq auto-save-default nil) ; because of low load speed

;; (setq auto-save-file-name-transforms
;; `((".*" "~/.cache/emacs/saves/" t)))

;; Open file in dired with xdg-open
;; (use-package dired
;;   :config
;;   (defun dired-open-file ()
;;     "In dired, open the file named on this line."
;;     (interactive)
;;     (let* ((file (dired-get-filename nil t)))
;;       (message "Opening %s..." file)
;;       (call-process "xdg-open" nil 0 nil file)
;;       (message "Opening %s done" file))

;;     ;; select file or directory.
;;     (define-key dired-mode-map (kbd "RET") 'dired-open-file)))

;; Set default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox-bin")

;; Allow commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; Disable eldoc autostart, enabled by default since 25
(global-eldoc-mode -1)

;; TODO: add var
;; Auto-indent when pasting
;; (dolist (command '(yank yank-pop))
;;   (eval `(defadvice ,command (after indent-region activate)
;;            (and (not current-prefix-arg)
;;                 (let ((mark-even-if-inactive transient-mark-mode))
;;                   (indent-region (region-beginning) (region-end) nil))))))


(provide 'env-settings)
