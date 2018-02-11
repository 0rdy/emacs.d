;; Module with useful custom functions -*- lexical-binding: t; -*-

;; Rename file and buffer
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;; Display face under cursor
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

;; Disable prompt in find file at point
(defun ffap-read-file-or-url (prompt guess)
  "Read file or URL from minibuffer, with PROMPT and initial GUESS."
  (or guess (setq guess default-directory))
  (let (dir)
    ;; Tricky: guess may have or be a local directory, like "w3/w3.elc"
    ;; or "w3/" or "../el/ffap.el" or "../../../"
    (or (ffap-url-p guess))
    (progn
      (or (ffap-file-remote-p guess)
          (setq guess
            (abbreviate-file-name (expand-file-name guess))))

      (setq dir (file-name-directory guess)))
    ;; Do file substitution like (interactive "F"), suggested by MCOOK.
    (or (ffap-url-p guess) (setq guess (substitute-in-file-name guess)))
    ;; Should not do it on url's, where $ is a common (VMS?) character.
    ;; Note: upcoming url.el package ought to handle this automatically.
    guess))


(defun line-length (n)
  "Length of the Nth line."
  (save-excursion
    (goto-char (point-min))
    (if (zerop (forward-line (1- n)))
        (- (line-end-position)
           (line-beginning-position)))))

(defun elmax/empty-line? ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

;; TODO: indent based languanges like Python
(defun elmax/smart-backspace ()
  (interactive)
  (if (elmax/empty-line?)
      (if (= (line-length (line-number-at-pos)) 0)
          (delete-indentation)
        (delete-horizontal-space))
    (backward-delete-char-untabify 1 nil)))

;; TODO: Jump to defenition
;; https://github.com/syl20bnr/spacemacs/blob/master/core/core-jump.el

;; -------------------------------------------------------------------------------------------------------------------------
;; Neo tree open xdg on point helpers
;; -------------------------------------------------------------------------------------------------------------------------
;; (defun xdg-open-from-kill-ring ()
;;   "Launch the default xdg appplication."
;;   (interactive)
;;   (shell-command (concat "xdg-open " (substring-no-properties (car kill-ring)))))
;; ;;change xdg-open to whatever launcher you have (xdg-open is the default on most linux systems)

;; (defun neotree-open-xdg-on-point ()
;;   "Open a file under point."
;;   (interactive)
;;   (progn
;;     (neotree-copy-filepath-to-yank-ring)
;;     (xdg-open-from-kill-ring)))

;; Add "J" as the key that will launch the function
;; (define-key neotree-mode-map (kbd "J") 'neotree-open-xdg-on-point)
;; function copied from spacemacs source code
;; modified function from http://emacswiki.org/emacs/AlignCommands
(defun align-repeat (start end regexp &optional justify-right after)
  "Repeat alignment with respect to the given regular expression.
  If JUSTIFY-RIGHT is non nil justify to the right instead of the
  left. If AFTER is non-nil, add whitespace to the left instead of
  the right."

  (interactive "r\nsAlign repeat regexp: ")
  (let* ((ws-regexp (if (string-empty-p regexp)
                        "\\(\\s-+\\)"
                      "\\(\\s-*\\)"))
         (complete-regexp (if after
                              (concat regexp ws-regexp)
                            (concat ws-regexp regexp)))
         (group (if justify-right -1 1)))
    (message "complete-regexp: %S" complete-regexp)
    (align-regexp start end complete-regexp group 1 t)))

(provide 'env-fu)
