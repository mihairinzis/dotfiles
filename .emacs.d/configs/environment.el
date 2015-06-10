;;; environment.el --- Environment config

;;; Commentary:
;;;
(cond
 ((string-equal system-type "gnu/linux")
  (progn
    ;; set path from shell
    (defun set-exec-path-from-shell-PATH ()
      (let ((path-from-shell (shell-command-to-string "$SHELL -c 'echo $PATH'")))
        (setenv "PATH" path-from-shell)
        (setq exec-path (split-string path-from-shell path-separator))))
    (when window-system (set-exec-path-from-shell-PATH))))
 ((string-equal system-type "windows-nt")
  (progn (setenv "PATH" (concat "~/apps/cygwin/bin" path-separator (getenv "PATH"))))))

;;; Code:

;;; environment.el ends here
