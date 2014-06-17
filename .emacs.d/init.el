;;; init.el --- Load config files in specific order

;;; Commentary:
;;;

;;; Code:

(let ((default-directory "~/projects/dotfiles/.emacs.d/"))
  (load-file (expand-file-name "configs/packages.el"))
  (load-file (expand-file-name "configs/misc.el"))
  (load-file (expand-file-name "configs/dired.el"))
  (load-file (expand-file-name "configs/erc.el"))
  )

;;; init.el ends here
