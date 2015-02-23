;;; packages.el --- Packages to install

;;; Commentary:
;;;

;;; Code:

;; set proxy
;; (setq url-proxy-services
;;       '(("http"     . "proxy.*:8080")
;;         ("https"    . "proxy.*:8080")
;;         ("ftp"      . "proxy.*:8080")
;;         ("no_proxy" . "^\\(localhost\\|10.*\\)")))

;; Packages to install
;; (package-initialize)
(defvar my-packages
  '(
    ;; icicles
    ;; auto-complete
    ;; company ; added to prelude
    ;; switch-window
    elpy
    regex-tool
    dired+
    js2-mode
    emmet-mode
    ;; smart-mode-line
    ibuffer-vc
    quickrun
    hydra
    )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;; packages.el ends here
