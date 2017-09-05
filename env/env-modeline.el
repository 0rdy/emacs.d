;; ;; Hide modes via rich minority
;; (use-package rich-minority
;;   :ensure t
;;   :config
;;   (setq rm-blacklist
;;         '(
;;           " yas"        ;; yasnippet
;;           " ctagsU"      ;; ctags update
;;           " Undo-Tree"      ;; undo tree
;;           " wr"        ;; Wrap Region
;;           " SliNav"      ;; elisp-slime-nav
;;           " Fly"        ;; Flycheck
;;           " GG"        ;; ggtags
;;           " ElDoc"      ;; eldoc
;;           " hl-highlight"
;;           " VHl"
;;           " ivy"
;;           " es"
;;           " company"
;;           " Parinfer:Indent"
;;           " Parinfer:Paren"
;;           " SP"
;;           " s-/")))

;; TODO: add icons
;; TODO: big modeline config
;; TODO: check if all-the-icons installed
;; TODO: (!!) flycheck segment
  ;; Gray "#545c5e"

;; Telephone line
(use-package telephone-line
  ;; :load-path "dev/telephone-line"
  :config
  ;; To create custom segments
  (use-package telephone-line-utils)

  ;; TODO:
  ;; TODO: choose separator by name
  (setq telephone-line-height 22)

  ;; Set default separators: choose either of them
  ;; (setq telephone-line-primary-left-separator 'telephone-line-flat)
  ;; (setq telephone-line-primary-right-separator 'telephone-line-flat)
  ;; OR
  (setq telephone-line-primary-left-separator 'telephone-line-identity-left)
  (setq telephone-line-primary-right-separator 'telephone-line-identity-right)
  ;; OR
  ;; (setq telephone-line-primary-left-separator 'telephone-line-cubed-left)
  ;; (setq telephone-line-primary-right-separator 'telephone-line-cubed-right)

  ;; Set subseparator
  (if window-system
      (progn
        (setq telephone-line-secondary-left-separator 'telephone-line-identity-hollow-left)
        (setq telephone-line-secondary-right-separator 'telephone-line-identity-hollow-right)))

  ;;;; Custom segments

  ;; Example of color string segment
  ;; (telephone-line-defsegment* my-color-segment
  ;;   (propertize "some-string" 'face `(:foreground "green")))


  ;; Display major mode
  ;; TODO: Rewrite using assoc and defvar #835d83
  (telephone-line-defsegment* my-major-mode-segment ()
    (let ((mode (cond
                  ((string= mode-name "Fundamental") "text")
                  ((string= mode-name "Emacs-Lisp") "elisp")
                  ((string= mode-name "Javascript-IDE") "js")
                  (t (downcase mode-name)))))
          ;; (icon (all-the-icons-icon-for-buffer)))
      ;; (concat
      ;;   (unless (symbolp icon) ;; This implies it's the major mode
      ;;     (format "%s "
      ;;             (propertize icon
      ;;                         'face `(:height 1.0 :family ,(all-the-icons-icon-family-for-buffer))
      ;;                         'display '(raise -0.1))))
      (propertize mode 'face `(:foreground "#9d81ba"))))
  ;; ;; Display name
  ;;   (propertize mode 'face `(:foreground "#9d81ba")))))

  ;; Display evil state
  (telephone-line-defsegment my-evil-segment ()
    (if (telephone-line-selected-window-active)
      (let ((tag (cond
                  ((string= evil-state "normal") ":")
                  ((string= evil-state "insert") ">")
                  ((string= evil-state "replace") "r")
                  ((string= evil-state "visual") "v")
                  ((string= evil-state "operator") "=")
                  ((string= evil-state "motion") "m")
                  ((string= evil-state "emacs") "Emacs")
                  (t "-"))))
        (concat " " tag))))

  ;; Display buffer name
  (telephone-line-defsegment my-buffer-segment ()
    `(""
      ,(telephone-line-raw mode-line-buffer-identification t)))


  ;; Display current position in a buffer
  (telephone-line-defsegment* my-position-segment ()
    (if (telephone-line-selected-window-active)
        (if (eq major-mode 'paradox-menu-mode)
            (telephone-line-trim (format-mode-line mode-line-front-space))
          '(" %3l,%2c "))))

  ;; Ignore some buffers in modeline
  (defvar modeline-ignored-modes nil
    "List of major modes to ignore in modeline")

  (setq modeline-ignored-modes '("Dashboard"
                                 "Warnings"
                                 "Compilation"
                                 "EShell"
                                 "REPL"
                                 "Messages"))

  ;; Display modified status
  (telephone-line-defsegment my-modified-status-segment ()
    (when (and (buffer-modified-p) (not (member mode-name modeline-ignored-modes)))
        (propertize "+" 'face `(:foreground "#85b654"))))


  ;; Display encoding system
  (telephone-line-defsegment my-coding-segment ()
    (let* ((code (symbol-name buffer-file-coding-system))
           (eol-type (coding-system-eol-type buffer-file-coding-system))
           (eol (cond
                 ((eq 0 eol-type) "unix")
                 ((eq 1 eol-type) "dos")
                 ((eq 2 eol-type) "mac")
                 (t ""))))
      (concat eol " ")))

  ;; Display current branch
  ;; TODO: move raise and etc into var
  (telephone-line-defsegment my-vc-segment ()
    ;; #6fb593 #4a858c
    (let ((fg-color "#6fb593")
          (backend (vc-backend buffer-file-name)))
      (format "%s %s"
        (propertize (all-the-icons-octicon "git-branch")
                    'face `(:family ,(all-the-icons-octicon-family) :height 1.0 :foreground ,fg-color)
                    'display '(raise 0.0))
        (propertize
         ;; TODO: fix error in the message buffer
         ;; wrong arrayp
          (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2))
          'face `(:foreground ,fg-color)))))

  ;; Left edge
  (setq telephone-line-lhs
        '((evil   . (my-evil-segment))
          (nil    . (my-buffer-segment))
          (nil    . (my-modified-status-segment))))

  ;; Right edge
  (setq telephone-line-rhs
        ;; '((nil     . ((my-vc-segment :active))))
        '((nil     . (my-vc-segment))
          (accent  . (my-position-segment))
          (nil     . (my-major-mode-segment))
          (accent  . ((my-coding-segment :active)))))

  (telephone-line-mode 1))

(provide 'env-modeline)
