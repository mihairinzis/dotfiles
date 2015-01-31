;;; dired.el --- Dired configuration

;;; Commentary:
;;;

;;; Code:

;; ergoemacs - open current / maked file((s) with external apps
(defun open-external ()
  "Open the current file or dired marked files in external app."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))) ) ) )

    (setq doIt (if (<= (length myFileList) 5) t
                 (y-or-n-p? "Open more than 5 files?") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\"
                                                                                  fPath t t)) ) myFileList) )
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open
        \"%s\"" fPath)) ) myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type
                                     nil)) (start-process "" nil "xdg-open" fPath)) )
              myFileList) ) ) ) ) )

(global-set-key (kbd "C-z o") 'open-external)

(require 'dired+)
;; make sizes human-readable by default, sort version numbers
;; correctly, and put dotfiles and capital-letters first.
;; (setq-default dired-listing-switches "-aGghlv --group-directories-first --time-style=+ ")

;; hide details on dired by default
;; (add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; remove dotfiles in dired-omit-mode
(require 'dired-x)
;; (setq-default dired-omit-mode t
;;               dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\.")
;; toggle omit mode C-o
(define-key dired-mode-map (kbd "C-'") 'dired-omit-mode)
;; make dired-omit-mode default
;; (add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
;; auto refresh dired, but be quiet about it
(setq-default global-auto-revert-non-file-buffers t)
(setq directory-free-space-args "-Pkh")
(setq dired-listing-switches "-laGh1v --group-directories-first")

;; get total size of marked files/dirs in dired
(defun dired-get-size ()
  "Get total size of current/marked dired items."
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message "Size of all marked files: %s"
               (progn
                 (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
                 (match-string 1))))))

(define-key dired-mode-map "a"
  (lambda ()
    (interactive)
    (find-alternate-file "..")))

;;; dired.el ends here
