;;; misc.el --- Personal configuration on top of prelude

;;; Commentary:
;;;

;;; Code:

;; el-get initialization
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

;; default settings
(setq-default
 user-full-name "Mihai Rinzis"
 tab-width 2
 icomplete-mode t
 ;; Disable guru mode (comes with prelude)
 prelude-guru nil
 ;; Enable hungry delete
 c-hungry-delete-key t
 auto-revert-verbose nil
 sentence-end-double-space nil)

(setq
 interprogram-cut-function 'x-select-text
 interprogram-paste-function 'x-selection-value
 save-interprogram-paste-before-kill t
 select-active-regions t
 x-select-enable-clipboard t
 x-select-enable-primary t
 initial-scratch-message nil
 apropos-do-all t)
;; initial-major-mode 'org-mode)

;; utf everywhere
(set-language-environment 'UTF-8)
(setq locale-coding-system 'utf-8
      buffer-file-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; ispell
;; find aspell and hunspell automatically
;; (cond
;;  ((executable-find "aspell")
;;   (setq ispell-program-name "aspell")
;;   (setq ispell-extra-args
;;         '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=5" "--run-together-min=2")))
;; ((executable-find "hunspell")
;;  (setq ispell-program-name "hunspell")
;;  (setq ispell-extra-args '("-d en_US")))
;;)
(setq-default ispell-list-command "list")
;; (setq-default ispell-dictionary "romanian")

;; move through camel case words
(global-subword-mode 1)

;; Key bindings
;; Unset C-z suspend
(global-unset-key "\C-z")
(bind-keys ("C-s" . isearch-forward-regexp)
           ("C-r" . isearch-backward-regexp)
           ("C-M-s" . isearch-forward)
           ("C-M-r" . isearch-backward))

;; q kills
(bind-keys :map dired-mode-map
           ("q" . kill-this-buffer))

(bind-keys :map package-menu-mode-map
           ("q" . kill-this-buffer))

(defun kill-and-join-forward (&optional arg)
  "If at end of line, join with following; otherwise kill line.
Deletes whitespace at join. With prefix ARG kills that many lines"
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    (kill-line arg)))

(global-set-key (kbd "C-k") 'kill-and-join-forward)

(use-package async
  :ensure t
  :defer t)

(use-package paradox
  :ensure t
  :commands (paradox-upgrade-packages paradox-list-packages)
  :config (setq paradox-execute-asynchronously t))

(use-package alert
  :ensure t
  :defer t)

(use-package wgrep
  :ensure t
  :defer t)

(use-package god-mode
  ;; :disabled t
  :ensure t
  :defer t
  :init
  (god-mode-all)
  (defun update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only) 'bar 'box)))
  (add-hook 'god-mode-enabled-hook 'update-cursor)
  (add-hook 'god-mode-disabled-hook 'update-cursor)
  :config
  (bind-keys :map god-local-mode-map
             ("z" . repeat)
             ("." . repeat)
             ("i" . god-local-mode)
             ("C-x C-1" . delete-other-windows)
             ("C-x C-2" . split-window-below)
             ("C-x C-3" . split-window-right)
             ("C-x C-0" . delete-window)
             ("f" . forward-word)
             ("b" . backward-word)
             ("q" . kill-this-buffer))
  (defun god-toggle-on-overwrite ()
    "Toggle god-mode on overwrite-mode."
    (if (bound-and-true-p overwrite-mode)
        (god-local-mode-pause)
      (god-local-mode-resume)))
  (add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)
  (add-to-list 'god-exempt-major-modes 'org-agenda-mode)
  (key-chord-define-global "gg" 'god-mode-all))


(use-package key-chord
  :ensure t
  :init (key-chord-mode +1)
  :config
  (setq key-chord-two-keys-delay 0.05)
  (key-chord-define-global "x1" 'delete-other-windows)
  (key-chord-define-global "0o" 'delete-window)
  (key-chord-define-global "xg" 'magit-status))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  (("C-c m n" . mc/mark-next-like-this)
   ("C-c m p" . mc/mark-previous-like-this)
   ("C-c m a" . mc/mark-all-like-this)
   ("C-c m l" . mc/edit-lines)
   ("C-S-<mouse-1>" . mc/add-cursor-on-click)))
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)

;; Comment or uncomment region or line
(defun comment-or-uncomment-line-or-region ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    )
  )
(global-set-key (kbd "C-c c") 'comment-or-uncomment-line-or-region)

;; recompile with f5
;; (global-set-key (kbd "<f5>") 'recompile)

;; A saner ediff
(use-package ediff
  :defer t
  :config
  (setq ediff-diff-options "-w"
        ediff-split-window-function 'split-window-horizontally
        ediff-window-setup-function 'ediff-setup-windows-plain)
  (add-hook 'ediff-after-quit-hook-internal 'winner-undo))

;; Set file registers
(set-register ?m '(file . "~/projects/dotfiles/.emacs.d/configs/misc.el"))
(set-register ?t '(file . "~/Dropbox/Privat/org/tasks.org"))

;; nxml tab width
(setq nxml-child-indent 2)
(setq nxml-attribute-indent 2)

;; Setup backup/auto-save
(setq backup-directory-alist
      `((".*" . ,"~/temp/emacs-bak")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/temp/emacs-bak" t)))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)

;; enable zone after a minute
;; (require 'zone)
;; (zone-when-idle 120)

;; yasnippet
(use-package yasnippet
  :ensure t
  :defer 10
  :config
  (define-key yas-minor-mode-map (kbd "C-c C-s") 'yas-insert-snippet)
  :init (yas-global-mode 1))
;; (yas/load-directory "~/.emacs.d/snippets")


;; web-mode
(use-package web-mode
  :ensure t
  :defer t
  :config
  (defun web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-indent-style 2)
    )
  (add-hook 'web-mode-hook 'web-mode-hook))

;; (require 'reftex)

;; icicles
;; (require 'icicles)
;; (setq-default icicle-show-Completions-initially-flag t)

;; setup elpy-mode
;; (package-initialize)
;; (require 'package)
;; (add-to-list 'package-archives
;;             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

;; (elpy-enable)
;; (elpy-use-ipython)
;; (autoload 'python-mode "python" "Python Mode." t)
;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code
;;  "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;  "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; configure ergoemacs
;; (require 'ergoemacs-mode)
;; (ergoemacs-ignore-prev-global)
;; (setq ergoemacs-theme nil)
;; (setq ergoemacs-keyboard-layout "us")
;; (ergoemacs-key "M-m" 'ergoemacs-end-of-line-or-what "End of line")
;; (ergoemacs-mode 1)

;;; Code:

;; set bookmarks files
(defvar emacsd-bookmarks-dir (expand-file-name "bookmarks" emacsd-dir)
  "Emacs.d bookmarks directory path.")
(setq-default bookmark-save-flag t)

;; platform specific settings
(cond
 ((string-equal system-type "gnu/linux")
  (progn
    ;; set bookmarks file
    (setq-default bookmark-default-file (expand-file-name "gnu-bookmarks.gpg"
                                                          emacsd-bookmarks-dir))
    )
  )
 ((string-equal system-type "windows-nt")
  (progn
    (message "You're screwed")
    ;; set bookmarks file
    (setq-default bookmark-default-file (expand-file-name "win-bookmarks.gpg"
                                                          emacsd-bookmarks-dir))
    (setq projectile-indexing-method 'alien)
    ))
 )

;; helm
(use-package helm
  :ensure t
  :init (global-set-key [remap prelude-goto-symbol] 'helm-semantic-or-imenu)
  :config
  (progn
    (setq helm-split-window-in-side-p nil
          helm-always-two-windows t
          helm-move-to-line-cycle-in-source nil)
    ;; try helm-swoop
    (use-package helm-swoop
      :ensure t
      :bind ("M-i" . helm-swoop)
      :config
      ;; When doing isearch, hand the word over to helm-swoop
      (bind-key "M-i" 'helm-swoop-from-isearch isearch-mode-map)
      ;; From helm-swoop to helm-multi-swoop-all
      (bind-key "M-i" 'helm-multi-swoop-all-from-helm-swoop helm-swoop-map))
    ;; replace find bookmarks with helm bookmarks
    ;; (global-set-key [remap bookmark-jump] 'helm-bookmarks)
    ))

(use-package eww-lnum
  :ensure t
  :defer 15
  :config
  (eval-after-load "eww"
    '(progn (define-key eww-mode-map "f" 'eww-lnum-follow)
            (define-key eww-mode-map "F" 'eww-lnum-universal))))

;; use ido for finding files and switching buffers
;; (define-key global-map (kbd "C-x b") 'ido-switch-buffer)
(define-key global-map (kbd "C-x C-f") 'ido-find-file)

;; undo-tree
;; (setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)

;; anzu stuff
;; (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
;; (global-set-key [remap query-replace] 'anzu-query-replace)

;; regex tool
(setq-default regex-tool-backend 'perl)
(use-package visual-regexp
  :ensure t
  :defer t
  :bind (("M-5" . vr/replace)
         ("M-%" . vr/query-replace)))

(use-package linum-relative
  ;; :ensure t
  :defer t
  :init (setq linum-format 'linum-relative)
  :config (setq linum-relative-current-symbol ""))

;; Roster Options
(use-package jabber
  :disabled t
  :ensure t
  :defer t
  :config
  (setq jabber-vcard-avatars-retrieve nil
        jabber-roster-show-title nil
        jabber-roster-show-bindings nil
        jabber-show-offline-contacts nil
        jabber-show-resources nil
        jabber-sort-order nil))

(use-package twittering-mode
  :disabled t
  :ensure t
  :defer t
  :config
  (setq twittering-use-master-password t
        twittering-icon-mode t
        twittering-use-icon-storage t))
;; (add-hook 'jabber-alert-message-hooks 'jabber-message-xmessage)

;; proced
(setq proced-tree-flag t)
(setq proced-auto-update-flag t)

;; guide-key
(use-package guide-key
  :ensure t
  :defer 15
  :init (guide-key-mode 1)
  :config
  (setq guide-key/guide-key-sequence t
        guide-key/recursive-key-sequence-flag t
        guide-key/popup-window-position 'bottom
        guide-key/highlight-command-regexp
        '(("rectangle" . font-lock-warning-face)
          ("register"  . font-lock-type-face)))
  (use-package guide-key-tip
    :disabled t
    :ensure t
    :defer t
    :init
    (guide-key-tip/toggle-enable)))

;; winner
(setq winner-boring-buffers '("*helm mini*"
                              "*helm projectile*"
                              "*helm M-x*"
                              "*helm resume*"
                              "*Completions*"
                              "*Compile-Log*"
                              "*inferior-lisp*"
                              "*Fuzzy Completions*"
                              "*Apropos*"
                              "*Help*"
                              "*cvs*"
                              "*Buffer List*"
                              "*Ibuffer*"
                              "*esh command on file*"
                              ))

;; aggressive-indent-mode
(use-package aggressive-indent
  :ensure t
  :diminish aggressive-indent-mode
  :defer t
  :init
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode))

(use-package number
  :ensure t
  :defer t
  :bind (("C-c C-+" . number/add)
         ("C-c C--" . number/sub)
         ("C-c C-*" . number/multiply)
         ("C-c C-/" . number/divide)))

(use-package ag
  :ensure t
  :defer t
  :init
  (use-package wgrep
    :ensure t)
  (use-package wgrep-ag
    :ensure t)
  :config
  (bind-keys :map ag-mode-map
             ("q" . kill-this-buffer))
  (setq ag-highlight-search t))

(use-package vlf
  :ensure t
  :defer t)

(use-package sunshine
  :ensure t
  :defer t
  :config
  (setq sunshine-location "Cluj-Napoca,RO"
        sunshine-show-icons t
        sunshine-units 'metric))

(use-package impatient-mode
  :ensure t
  :defer t)

(use-package pretty-mode
  :ensure t
  :init (global-pretty-mode t))

(use-package diff-hl
  :config
  (progn
    (defhydra hydra-diff-hl (:color red)
      "diff-hl"
      ("="     diff-hl-diff-goto-hunk "goto hunk")
      ("<RET>" diff-hl-diff-goto-hunk "goto hunk")
      ("u"     diff-hl-revert-hunk    "revert hunk")
      ("["     diff-hl-previous-hunk  "prev hunk")
      ("p"     diff-hl-previous-hunk  "prev hunk")
      ("]"     diff-hl-next-hunk      "next hunk")
      ("n"     diff-hl-next-hunk      "next hunk")
      ("q" nil                    "cancel"))
    (add-hook 'dired-mode-hook #'diff-hl-dired-mode)))

;; (key-chord-define-global
;;  "rr"
;;  (defhydra hydra-window-resize ()
;;    "resizer"
;;    ("l" enlarge-window-horizontally "horiz-enlarge")
;;    ("h" shrink-window-horizontally "horiz-shrink")
;;    ("k" enlarge-window "vert-enlarge")
;;    ("j" shrink-window "vert-shrink")))

;; (require 'hydra-examples)
;; (define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)
;; (defhydra hydra-ibuffer-menu (:color pink)
;;   "
;;   Mark               Unmark             Actions            Search
;; -------------------------------------------------------------------------
;; _m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
;; _s_: save          _U_: unmark up     _b_: bury          _I_: isearch
;; _d_: delete                           _g_: refresh       _O_: multi-occur
;; _D_: delete up                        _T_: files only: %`Buffer-menu-files-only
;; _~_: modified
;; "
;;   ("m" ibuffer-mark-forward nil)
;;   ("u" Buffer-menu-unmark nil)
;;   ("U" Buffer-menu-backup-unmark nil)
;;   ("d" Buffer-menu-delete nil)
;;   ("D" Buffer-menu-delete-backwards nil)
;;   ("s" Buffer-menu-save nil)
;;   ("~" Buffer-menu-not-modified nil)
;;   ("x" Buffer-menu-execute nil)
;;   ("b" Buffer-menu-bury nil)
;;   ("g" revert-buffer nil)
;;   ("T" Buffer-menu-toggle-files-only nil)
;;   ("O" Buffer-menu-multi-occur nil :color blue)
;;   ("I" Buffer-menu-isearch-buffers nil :color blue)
;;   ("R" Buffer-menu-isearch-buffers-regexp nil :color blue)
;;   ("c" nil "cancel")
;;   ("v" Buffer-menu-select "select" :color blue)
;;   ("o" Buffer-menu-other-window "other-window" :color blue)
;;   ("q" quit-window "quit" :color blue))

;; (define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)

;; (defun hydra-god/pre ()
;;   (set-cursor-color "#e52b50"))

;; (defun hydra-god/post ()
;;   (set-cursor-color "#ffffff"))

;; (global-set-key
;;  (kbd "C-c v")
;;  (defhydra hydra-god (:pre hydra-god/pre :post hydra-fod/post)
;;    "god"
;;    ("f" forward-char)
;;    ("b" backward-char)
;;    ("n" next-line)
;;    ("p" previous-line)
;;    ("m" set-mark-command "mark")
;;    ("a" move-beginning-of-line "beg")
;;    ("e" move-end-of-line "end")
;;    ("w" delete-region "del" :color blue)
;;    ("y" kill-ring-save "yank" :color blue)
;;    ("q" nil "quit")))


;;; misc.el ends here
