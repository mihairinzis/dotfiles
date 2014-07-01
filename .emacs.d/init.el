;;; init.el --- Load config files in specific order

;;; Commentary:
;;;

;;; Code:

(defvar emacsd-dir (file-name-directory "~/projects/dotfiles/.emacs.d/" )
  "Emacs.d directory path.")
(defvar emacsd-configs-dir (expand-file-name "configs" emacsd-dir)
  "Emacs.d configuration directory path.")

(load-file (expand-file-name "packages.el" emacsd-configs-dir))
(load-file (expand-file-name "misc.el" emacsd-configs-dir))
(load-file (expand-file-name "dired.el" emacsd-configs-dir))

;;; init.el ends here