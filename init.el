;;;; Elmax - Emacs configuration with Evil
;; Kull Wahad! Kull Wahad! Kull Wahad!

;; el-get

;; General configation

;; (setq debug-on-error t)

(require 'package)
(setq package-enable-at-startup nil   ; To prevent initialising twice
      package--init-file-ensured t)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

;; Use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(load (concat user-emacs-directory "env/env-boot"))

(require 'env-common)
(require 'env-maps)
(require 'env-evil)
(require 'env-check)
(require 'env-company)
(require 'env-face)
;; (require 'env-dashboard)
(require 'env-ivy)
(require 'env-plugins)
(require 'env-lisp)
(require 'env-dev)
(require 'use-vcs)

;; Mode-line
(require 'modeline-common)

;; Specific modules and major modes
(require 'use-eshell)
(require 'use-grep)

;; (require 'use-clj)
(require 'use-nim)
(require 'use-org)
(require 'use-web)
(require 'use-js)
(require 'use-elixir)

(require 'env-fu)

;; OLD stuff
;; (require 'env-sp)
;; (require 'use-multiedit)

;; (~ ^ . ^ ~)
