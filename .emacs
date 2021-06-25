(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile (require 'use-package)))
(setq use-package-always-ensure t)

(use-package undo-tree :defer 5 :config (global-undo-tree-mode 1))

(use-package ivy :config (ivy-mode t))
(use-package counsel
  :config (counsel-mode)
  :bind (("C-x b" . counsel-switch-buffer)))
(use-package counsel-tramp)
(use-package swiper :bind (("C-s" . counsel-grep-or-swiper)))
(use-package marginalia :init (marginalia-mode))

(use-package easy-kill)
(use-package move-text :config (move-text-default-bindings))

(use-package which-key :config (add-hook 'after-init-hook 'which-key-mode))

(use-package browse-kill-ring)

(use-package magit :bind ("C-x g" . magit-status))

(use-package expand-region :bind ("C-=" . er/expand-region))

(use-package zenburn-theme :config (load-theme 'zenburn t))
(use-package doom-modeline :init (doom-modeline-mode 1))

(use-package diredfl :config (diredfl-global-mode 1))
(use-package all-the-icons)
(use-package all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode +1)))
(use-package consult-dir
  :ensure t
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))
;; (use-package dired-subtree)

(use-package dashboard :config (dashboard-setup-startup-hook))
(setq dashboard-items '((recents  . 5) (bookmarks . 5) (projects . 5)))

(use-package projectile :diminish projectile-mode :config (projectile-mode))

(use-package crux
  :bind (("C-a" . crux-move-beginning-of-line)
	 ("C-c d" . crux-duplicate-current-line-or-region)
	 ("C-c n" . crux-cleanup-buffer-or-region)))

(use-package company
  :init (global-company-mode)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
	  ;; Easy navigation to candidates with M-<n>
	  company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package flycheck :init (global-flycheck-mode))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(use-package treemacs)
(use-package json-mode)

;; npm install -g @angular/language-service@next typescript @angular/language-server vscode-html-languageserver-bin
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (html-mode . lsp)
	 (typescript-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (progn
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
    (setq js-indent-level 2)))
(use-package lsp-ui)
(use-package lsp-treemacs :init (lsp-treemacs-sync-mode 1))
(use-package lsp-ivy)
(use-package typescript-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
  (setq typescript-indent-level 2))


;; ;; LSP for JavaScript and TypeScript
;; (use-package lsp-javascript-typescript
;;   :ensure t
;;   :init
;;   (add-to-list 'js-mode-hook #'lsp-javascript-typescript-enable)
;;   (add-to-list 'typescript-mode-hook #'lsp-javascript-typescript-enable))

(use-package multiple-cursors
  :bind (("C-c SPC" . set-rectangular-region-anchor)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this)))

;; Appearance
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(linum-mode 1)
;; (setq-default cursor-type 'bar)
(show-paren-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings)
(setq inhibit-startup-screen t)
;; Font
(cond
 ((find-font (font-spec :name "Firacode"))
  (set-frame-font "Firacode-10"))
 ((find-font (font-spec :name "Hack"))
  (set-frame-font "Hack-11"))
 ((find-font (font-spec :name "inconsolata"))
  (set-frame-font "inconsolata-13"))
 ((find-font (font-spec :name "Noto Sans"))
  (set-frame-font "Noto Sans-12"))
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-frame-font "DejaVu Sans Mono-12")))


;; Misc
(global-auto-revert-mode t)
(setq auto-revert-verbose nil)
(which-function-mode t)
(global-subword-mode t)
(setq password-cache-expiry nil)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)
(global-font-lock-mode t)
(delete-selection-mode t)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq c-hungry-delete-key t)
(setq make-backup-files nil)

;; Defuns and keymap
(defun comment-or-uncomment-line-or-region ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    ))
;; Global keys
(global-set-key (kbd "M-SPC") 'cycle-spacing)
(global-set-key (kbd "C-c c") 'comment-or-uncomment-line-or-region)

;; dired
(define-key dired-mode-map (kbd "q") 'kill-this-buffer)
(define-key dired-mode-map "a" 'dired-up-directory)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
(setq dired-dwim-target t)
(require 'dired-x)

(use-package disk-usage)

;; ediff
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

(setq tab-always-indent 'complete)
(global-set-key [remap kill-ring-save] 'easy-kill)
(global-set-key [remap mark-sexp] 'easy-mark)

;; save recent files
(require 'recentf)
(recentf-mode +1)
(setq recentf-max-saved-items 500
      recentf-max-menu-items 15
      ;; disable recentf-cleanup on Emacs start, because it can cause
      ;; problems with remote files
      recentf-auto-cleanup 'never)
(global-set-key (kbd "C-c f") 'crux-recentf-find-file)

;; (define-key dired-mode-map (kbd "?") 'dired-get-size)



;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (linum-mode t)
;;             (setq show-trailing-whitespace)))

(projectile-register-project-type 'gradle '("build.gradle")
				  :project-file "build.gradle"
				  :compile "chmod +x gradlew && ./gradlew clean && ./gradlew build")

(defun download-video()
  (interactive)
  (let* ((dl-command "youtube-dl")
	 (video-filename "--output ~/'%(title)s.%(ext)s'")
	 (format " -f 303")
	 (url (concat "'" (current-kill 0 t) "'")))
    (async-shell-command (concat dl-command " " video-filename format " " url))))

(defun download-mp3()
  (interactive)
  (let* ((dl-command "youtube-dl")
	 (video-filename "--output ~/'%(title)s.%(ext)s'")
	 (format "--extract-audio --audio-format")
	 (format-extension "mp3")
	 (url (concat "'" (current-kill 0 t) "'")))
    (async-shell-command (concat dl-command " " video-filename " " format " " format-extension " " url))))

(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
		   (concat
		    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
		    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(consult-dir disk-usage diredfl dired-subtree dired-rainbow multiple-cursors lsp-ivy eslint yasnippet company-box lsp-treemacs json-mode treemacs eglot symon counsel-tramp counsel smartparens lsp-ui lsp-mode flycheck anzu move-text easy-kill browse-kill-ring company smart-mode-line swiper crux use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
