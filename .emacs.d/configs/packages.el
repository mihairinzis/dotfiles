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
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing.  Install it? " package))
           (package-install package))))
 '(
   multiple-cursors
   yasnippet
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
   powerline
   visual-regexp
   visual-regexp-steroids
   ibuffer-vc
   ))

;;; packages.el ends here
