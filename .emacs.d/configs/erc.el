;;; erc.el --- Erc configuration

;;; Commentary:
;;;

;;; Code:

(require 'erc-join)
(erc-autojoin-mode 1)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs")))

(require 'erc-track)
(erc-track-mode t)

(add-hook 'erc-mode-hook
          '(lambda ()
             (require 'erc-pcomplete)
             (pcomplete-erc-setup)
             (erc-completion-mode 1)))

(require 'erc-fill)
(erc-fill-mode t)

(require 'erc-ring)
(erc-ring-mode t)

(require 'erc-netsplit)
(erc-netsplit-mode t)

(erc-timestamp-mode t)
(setq erc-timestamp-format "[%R-%m/%d]")

(erc-button-mode nil)

(add-to-list 'erc-modules 'smiley)
;; (add-to-list 'erc-modules 'match)
(add-to-list 'erc-modules 'scrolltobottom)
(add-to-list 'erc-modules 'notifications)

;;; erc.el ends here
