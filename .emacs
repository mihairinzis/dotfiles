(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-variables '("PATH"
				    "MANPATH"))
  :config (exec-path-from-shell-initialize))

(use-package gcmh
  :demand
  :hook
  (focus-out-hook . gcmh-idle-garbage-collect)
  :config
  (gcmh-mode +1))

(use-package undo-tree
  :defer 5
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-visualizer-diff t
	undo-tree-visualizer-timestamps t))
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(use-package vertico
  :init
  (fido-mode -1)
  (vertico-mode)
  :config
  (setq vertico-cycle t))

(use-package corfu
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-scroll-margin 5)        ;; Use scroll margin
  ;; (corfu-popupinfo-mode)
  :init
  (global-corfu-mode))

;; ;; Pretty icons for corfu
(use-package kind-icon
  :if (display-graphic-p)
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Consult: Misc. enhanced commands
(use-package consult
  :bind (;; ("C-x b" . consult-buffer)
	 ("M-y" . consult-yank-pop) ;; orig. yank-pop
	 ("C-s" . consult-line)     ;; orig. isearch
	 )
  )

;; Orderless: powerful completion style
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

(use-package prescient
  :config
  (setq consult-preview-key "M-.")
  (prescient-persist-mode))

(use-package yaml-mode)

;; (use-package counsel
;;   :config (counsel-mode)
;;  :bind (("C-x b" . counsel-switch-buffer))) ;

(use-package marginalia :init (marginalia-mode))

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  :config
  (add-to-list 'display-buffer-alist
	       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
		 nil
		 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package easy-kill)
(use-package move-text :config (move-text-default-bindings))

(use-package which-key :config (add-hook 'after-init-hook 'which-key-mode))

(use-package browse-kill-ring)

(use-package magit :bind ("C-x g" . magit-status))
(use-package magit-delta
  :hook (magit-mode . magit-delta-mode))
(use-package magit-gitflow
  :defer t
  :after magit
  :hook (magit-mode . turn-on-magit-gitflow))

(use-package expand-region :bind ("C-=" . er/expand-region))

(use-package zenburn-theme :config (load-theme 'zenburn t))
(use-package doom-modeline
  :config
  (setq doom-modeline-height 30
	doom-modeline-bar-width 1
	doom-modeline-buffer-encoding nil
	doom-modeline-buffer-file-name-style 'truncate-except-project)
  (set-face-background 'doom-modeline-bar (face-background 'mode-line))
  (doom-modeline-mode 1))

(use-package evil-nerd-commenter
  :config (evilnc-default-hotkeys))

(use-package editorconfig
  :defer t
  :diminish editorconfig-mode
  :init (editorconfig-mode t))

;; (use-package diredfl :config (diredfl-global-mode 1))

;; (use-package all-the-icons)
;; (use-package all-the-icons-dired)
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(use-package nerd-icons)

(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode))

;; (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode +1)))
(use-package consult-dir
  :bind (("C-x C-d" . consult-dir)
	 :map minibuffer-local-completion-map
	 ("C-x C-d" . consult-dir)
	 ("C-x C-j" . consult-dir-jump-file)))

(use-package bufler
  :bind
  ("C-x b" . bufler-switch-buffer)
  ("C-x C-b" . bufler-list))

(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  :custom
  (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
	  #'TeX-revert-document-buffer)

(use-package dashboard
  :config
  (setq
   dashboard-projects-backend 'project-el
   dashboard-display-icons-p t
   dashboard-set-heading-icons t
   dashboard-set-file-icons t
   dashboard-items '((recents  . 5) (bookmarks . 5) (projects . 5))
   dashboard-center-content t
   ;; dashboard-set-footer nil
   dashboard-path-style 'truncate-middle
   dashboard-path-max-length 60
   initial-buffer-choice
   (lambda () (get-buffer-create "*dashboard*") (dashboard-open)))
  (dashboard-setup-startup-hook))

(use-package git-gutter-fringe
  :hook ((prog-mode     . git-gutter-mode)
	 (org-mode      . git-gutter-mode)
	 (markdown-mode . git-gutter-mode)
	 (latex-mode    . git-gutter-mode)))

;;(use-package projectile :diminish projectile-mode :config (projectile-mode))

(use-package crux
  :bind (("C-a" . crux-move-beginning-of-line)
	 ("C-c d" . duplicate-dwim)
	 ("C-c n" . crux-cleanup-buffer-or-region)))

;; (use-package company
;;   :init (global-company-mode)
;;   :config
;;   (progn
;;     ;; Use Company for completion
;;     (bind-key [remap completion-at-point] #'company-complete company-mode-map)

;;     (setq company-tooltip-align-annotations t
;;        ;; Easy navigation to candidates with M-<n>
;;        company-show-numbers t)
;;       (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
;;     (setq company-dabbrev-downcase nil))
;;   :diminish company-mode)

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

(use-package flycheck :init (global-flycheck-mode))

(use-package smartparens
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-mode-hook #'display-line-numbers-mode)

(use-package treemacs)
(use-package json-mode)

;; npm install -g @angular/language-service@next typescript @angular/language-server vscode-html-languageserver-bin
;; (use-package lsp-mode
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (
;;          (html-mode . lsp)
;;       (typescript-mode . lsp)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :config
;;   (progn
;;     (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;     (setq js-indent-level 2)))
;; (use-package lsp-ui)
;; (use-package lsp-treemacs :init (lsp-treemacs-sync-mode 1))

;; (use-package lsp-mode
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   (setq lsp-enable-folding nil
;;         lsp-idle-delay 0.500
;;         lsp-enable-text-document-color nil
;;         ;; Reduce unexpected modifications to code
;;         lsp-enable-on-type-formatting nil
;;         ;; Make breadcrumbs opt-in; they're redundant with the modeline and imenu
;;         lsp-treemacs-sync-mode 1
;;         ;; performance tips from [[https://ianyepan.github.io/posts/emacs-ide/][source]]
;;         lsp-eldoc-hook nil
;;         lsp-eldoc-render-all nil
;;         lsp-enable-imenu t
;;         lsp-enable-on-type-formatting nil
;;         lsp-enable-snippet nil
;;         lsp-enable-symbol-highlighting nil
;;         lsp-headerline-breadcrumb-enable t
;;         lsp-log-io nil
;;         ;;lsp-modeline-code-actions-enable nil
;;         lsp-modeline-diagnostics-enable nil
;;         lsp-restart 'auto-restart
;;         ;;lsp-semantic-tokens-enable nil
;;         ;;lsp-signature-auto-activate nil
;;         lsp-signature-render-documentation nil)
;;   :hook (
;;          (typescript-mode . lsp-deferred)
;;          (dart-mode . lsp-deferred)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands (lsp lsp-deferred))

;; (use-package lsp-treemacs
;;   :after lsp-mode)

;; (use-package lsp-tailwindcss
;;   :init (setq lsp-tailwindcss-add-on-mode t)
;;   :config (add-to-list 'lsp-tailwindcss-major-modes 'typescript-tsx-mode :append)
;;   :after (lsp-mode))

;; (use-package lsp-ui
;;   :commands lsp-ui-mode
;;   :hook (lsp-mode . lsp-ui-mode)
;;   ;; :custom ()
;;   :config
;;   (setq lsp-eldoc-render-all nil
;;         lsp-signature-auto-activate nil
;;         lsp-ui-doc-delay 1.3
;;         lsp-ui-doc-enable t
;;         lsp-ui-doc-include-signature t
;;         lsp-ui-doc-position 'at-point
;;         lsp-ui-doc-show-with-cursor nil
;;         lsp-ui-doc-show-with-mouse t
;;         lsp-ui-doc-use-childframe t
;;         lsp-ui-peek-enable t
;;         lsp-ui-sideline-show-code-actions t
;;         lsp-ui-sideline-delay 0.05
;;         lsp-ui-doc-border (face-foreground 'default))

;;   (define-key lsp-ui-mode-map (kbd "C-M-.") #'lsp-ui-peek-find-definitions)
;;   (define-key lsp-ui-mode-map (kbd "C-M-?") #'lsp-ui-peek-find-references))


;; (use-package lsp-ivy)

(use-package tree-sitter
  :config
  ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (global-tree-sitter-mode)
  ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
  ;; by switching on and off
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs :after tree-sitter)

(use-package eglot
  :custom
  (eglot-autoshutdown t)
  :hook
  (typescript-mode . eglot-ensure)
  :init
  (put 'eglot-server-programs 'safe-local-variable 'listp)
  :config
  (add-to-list 'eglot-stay-out-of 'eldoc-documentation-strategy)
  (put 'eglot-error 'flymake-overlay-control nil)
  (put 'eglot-warning 'flymake-overlay-control nil)
  (advice-add 'eglot--apply-workspace-edit :after #'me/project-save)
  (advice-add 'project-kill-buffers :before #'me/eglot-shutdown-project))

(use-package eglot-java)

(use-package typescript-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
  (setq typescript-indent-level 2))

(use-package emmet-mode
  :defer
  :hook ((css-mode  . emmet-mode)
	 (html-mode . emmet-mode)
	 (web-mode  . emmet-mode)
	 (sass-mode . emmet-mode)
	 (scss-mode . emmet-mode)
	 (web-mode  . emmet-mode)))
(use-package auto-rename-tag)
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.tsx\\'" . web-mode)
	 ("\\.js[x]?\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
	web-mode-enable-auto-indentation nil
	web-mode-css-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-block-padding 2
	web-mode-comment-style 2
	web-mode-enable-css-colorization t
	web-mode-enable-auto-pairing t
	web-mode-enable-comment-keywords t
	web-mode-enable-current-element-highlight t
	web-mode-enable-current-column-highlight t
	web-mode-content-types-alist  '(("django" . "\\.tpl\\'"))
	web-mode-content-types-alist  '(("jsx" . "\\.js[x]?\\'"))))

(add-hook 'web-mode-hook  'auto-rename-tag-mode)
(add-hook 'web-mode-hook 'lsp-deferred
	  (lambda () (pcase (file-name-extension buffer-file-name)
		       ("tsx" ('lsp-deferred)))))

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

(use-package highlight-indent-guides
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))

;; Appearance
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(pixel-scroll-precision-mode t)
(setq vc-follow-symlinks nil)
(show-paren-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings)
(setq inhibit-startup-screen t)
;; Font
(cond
 ((find-font (font-spec :name "Firacode"))
  (set-frame-font "Firacode-12"))
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
(save-place-mode 1)
(setq use-dialog-box nil)
(setq show-trailing-whitespace t)
(setq undo-limit 100000000)
(setq show-paren-context-when-offscreen t)
(setq warning-minimum-level :error)

(use-package hungry-delete
  :config (global-hungry-delete-mode))

;; Defuns and keymap
;; (defun comment-or-uncomment-line-or-region ()
;;   "Comments or uncomments the current line or region."
;;   (interactive)
;;   (if (region-active-p)
;;       (comment-or-uncomment-region (region-beginning) (region-end))
;;     (comment-or-uncomment-region (line-beginning-position) (line-end-position))
;;     ))
;; Global keys
;; (global-set-key (kbd "M-SPC") 'cycle-spacing)
(global-set-key (kbd "C-c c") 'comment-or-uncomment-line-or-region)

;; dired
;; (define-key dired-mode-map (kbd "q") 'kill-this-buffer)
;; (define-key dired-mode-map "a" 'dired-up-directory)

(use-package dirvish
  :defer t
  :init (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries
   '(("h" "~/" "Home")
     ("d" "~/Downloads/" "Downloads")))
  (dirvish-mode-line-format
   '(:left (sort file-time "" file-size symlink) :right (omit yank index)))
  (dirvish-attributes '(nerd-icons file-size collapse subtree-state vc-state git-msg))
  :config
  (dirvish-peek-mode)
  (setq dired-dwim-target         t
	dired-recursive-copies    'always
	dired-recursive-deletes   'top
	dirvish-preview-dispatchers (cl-substitute 'pdf-preface 'pdf dirvish-preview-dispatchers)
	dired-listing-switches
	"-l --almost-all --human-readable --group-directories-first --no-group")
  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("a"   . dired-up-directory)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)))

(require 'dired-x)

(use-package diredfl
  :hook
  ((dired-mode . diredfl-mode)
   ;; highlight parent and directory preview as well
   (dirvish-directory-view-mode . diredfl-mode))
  :config
  (set-face-attribute 'diredfl-dir-name nil :bold t))


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

;; (projectile-register-project-type 'gradle '("build.gradle")
;;				  :project-file "build.gradle"
;;				  :compile "chmod +x gradlew && ./gradlew clean && ./gradlew build")

(defun download-video()
  (interactive)
  (let* ((dl-command "yt-dlp")
	 (video-filename "--output ~/'%(title)s.%(ext)s'")
	 (format " -f 303")
	 (url (concat "'" (current-kill 0 t) "'")))
    (async-shell-command (concat dl-command " " video-filename format " " url))))

(defun download-mp3()
  (interactive)
  (let* ((dl-command "yt-dlp")
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
   '(hungry-delete eglot gcmh embark git-gutter-fringe bufler dirvish
		   editorconfig evil-nerd-commenter magit-gitflow
		   exec-path-from-shell nerd-icons-completion
		   nerd-icons-dired jinx tabspaces pdf-tools
		   magit-delta docker tree-sitter-langs tree-sitter
		   lsp-tailwindcss yaml-mode emmet-mode
		   auto-rename-tag web-mode flyspell
		   highlight-indent-guides centaur-tabs dimmer
		   eglot-java prescient consult-dir
		   disk-usage diredfl dired-subtree dired-rainbow
		   multiple-cursors lsp-ivy eslint yasnippet
		   company-box lsp-treemacs json-mode treemacs symon
		   counsel-tramp counsel smartparens lsp-ui lsp-mode
		   flycheck anzu move-text easy-kill browse-kill-ring
		   company smart-mode-line swiper crux use-package))
 '(safe-local-variable-values
   '((vc-prepare-patches-separately)
     (diff-add-log-use-relative-names . t)
     (vc-git-annotate-switches . "-w"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
