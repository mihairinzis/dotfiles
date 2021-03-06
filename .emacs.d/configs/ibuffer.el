;;; ibuffer.el --- Ibuffer configuration

;;; Commentary:
;;;
;;; mostly borrowed from
;;; https://github.com/redguardtoo/emacs.d/blob/master/init-ibuffer.el

;;; Code:

(eval-after-load 'ibuffer
  '(progn
     ;; Use human readable Size column instead of original one
     (define-ibuffer-column size-h
       (:name "Size" :inline t)
       (cond
        ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
        ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
        (t (format "%8d" (buffer-size)))))
     ;; (require 'ibuffer-vc)
     (setq ibuffer-expert t
           ibuffer-show-empty-filter-groups nil
           ibuffer-display-summary t)
     (setq ibuffer-saved-filter-groups
           (quote (("default"
                    ("code"(or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode)
                               (mode . java-mode) (mode . idl-mode) (mode . web-mode)
                               (mode . lisp-mode) (mode . js2-mode) (mode . js-mode)
                               (mode . c++-mode) (mode . lua-mode) (mode . cmake-mode)
                               (mode . ruby-mode) (mode . scss-mode) (mode . css-mode)
                               (mode . csharp-mode) (mode . objc-mode) (mode . sql-mode)
                               (mode . python-mode) (mode . coffee-mode) (mode . php-mode)
                               (mode . sh-mode) (mode . json-mode) (mode . scala-mode)
                               (mode . go-mode) (mode . erlang-mode)))
                    ("dired" (or (mode . dired-mode) (mode . sr-mode)))
                    ("erc" (mode . erc-mode))
                    ("planner" (or (name . "^\\*Calendar\\*$") (name . "^diary$")
                                   (mode . muse-mode) (mode . org-mode) (mode . org-agenda-mode)))
                    ("emacs" (or (name . "^\\*scratch\\*$") (name . "^\\*Messages\\*$")))
                    ("jabber" (or (mode . jabber-chat-mode) (mode . jabber-roster-mode)))
                    ("gnus" (or (mode . message-mode) (mode . bbdb-mode) (mode . mail-mode)
                                (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)
                                (name . "^\\.bbdb$") (name . "^\\.newsrc-dribble")))))))
     (add-hook 'ibuffer-mode-hook
               (lambda ()
                 ;; (ibuffer-vc-set-filter-groups-by-vc-root)
                 (unless (eq ibuffer-sorting-mode 'filename/process)
                   (ibuffer-do-sort-by-filename/process))
                 (ibuffer-switch-to-saved-filter-groups "default")))))

(setq ibuffer-filter-group-name-face 'font-lock-doc-face)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
          (lambda () (ibuffer-switch-to-saved-filter-groups "default")))

;;; ibuffer.el ends here
