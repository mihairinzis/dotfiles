;;; org.el --- Org-mode config

;;; Commentary:
;;;

;;; Code:

(setq org-directory "~/Dropbox/Privat/org")
(setq org-agenda-files (list (concat org-directory "/tasks.org")))
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; display images
(setq org-startup-with-inline-images (display-graphic-p))

;; track times
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; curate this
(setq org-hide-leading-stars t
      org-src-fontify-natively t
      org-startup-indented t
      org-completion-use-iswitchb t
      org-log-done t
      org-email-link-description-format "Email %c (%d): %s"
      org-agenda-include-diary t
      org-enforce-todo-dependencies t
      ;; org clock
      org-clock-persist-query-save t
      org-clock-persistence-insinuate t
      org-clock-persist t
      org-clock-in-resume t
      org-clock-in-switch-to-state "STARTED"
      org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

;;; org.el ends here
