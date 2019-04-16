;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ansible
     typescript
     selectric
     ;; python
     yaml
     ;; csv
     ;; elixir
     ;; python
     ;; typescript
     auto-completion
     better-defaults
     emacs-lisp
     git
     markdown
     multiple-cursors
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     version-control
     (colors :variables colors-enable-rainbow-identifiers t)
     html
     javascript
     ;; jabber
     shell-scripts
     ;; latex
     restclient
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     ;; sql
     ivy
     java
     ;; (ranger :variables ranger-show-preview t)
     ;; spacemacs-ivy
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '(dired-filetype-face
                                      ;; tide
                                      ;; ng2-mode
                                      ;; dired+
                                      forge
                                      dired-du
                                      ;; treemacs
                                      counsel-tramp
                                      all-the-icons
                                      prettier-js)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(zenburn
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("DejaVu Sans Mono"
                               :size 14
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state t

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup `trailing

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

;; Comment or uncomment region or line
(defun comment-or-uncomment-line-or-region ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    ))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  ;; Windmove default
  (windmove-default-keybindings)
  (setq windmove-wrap-around t )
  ;; (golden-ratio-mode)
  ;; Overwrite highlighted
  (delete-selection-mode t)
  ;; Remove trailing whitespace on save
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  ;; Enable hungry delete
  (setq c-hungry-delete-key t)
  ;; Powerline: current time
  (display-time-mode t)
  ;; Powerline: battery life
  (fancy-battery-mode t)
  ;; Powerline: separator style
  (setq powerline-default-separator 'arrow)
  ;; CamelCase
  (global-subword-mode 1)
  ;; Sane dired
  (setq dired-dwim-target t)
  (setq delete-by-moving-to-trash nil)
  (setq dired-listing-switches "-alh")
  (dired-async-mode t)

  (setq password-cache-expiry nil)

  ;; platform specific settings
  (cond
   ((string-equal system-type "gnu/linux")
    (progn
      ;; set bookmarks file
      ;; (setq-default bookmark-default-file (expand-file-name "gnu-bookmarks.gpg"
      ;;                                                      emacsd-bookmarks-dir))
      ;; (setq tern-command '("node" "/home/mihai/node_modules/tern/bin/tern"))
      )
    )
   ((string-equal system-type "windows-nt")
    (progn
      (message "You're screwed")
      ;; Tern
      ;; (setq tern-command '("node" "C:/Users/rmi/AppData/Roaming/npm/node_modules/tern/bin/tern"))
      ;; set bookmarks file
      ;; (setq-default bookmark-default-file (expand-file-name "win-bookmarks.gpg"
      ;; emacsd-bookmarks-dir))
      (setq projectile-indexing-method 'alien)
      ))
   )

  ;; Layer settings: ranger
  ;; (setq ranger-cleanup-on-disable t)
  (setq ranger-cleanup-eagerly t)
  ;; (setq ranger-max-preview-size 2)
  ;; Package settings: anzu
  (use-package anzu
    :defer t
    :config
    (global-anzu-mode t)
    (global-set-key (kbd "M-%") 'anzu-query-replace)
    (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp))
  ;; package settings: dired-du
  (use-package dired-du
    :defer t
    :config
    (setq dired-du-size-format t))
  ;; Package settings: emms
  (use-package emms
    :defer t
    :config
    (progn
      (require 'emms-setup)
      (require 'emms-mode-line-cycle)
      (require 'emms-mode-line-icon)
      (emms-all)
      (emms-default-players)
      (emms-mode-line-enable)
      (emms-playing-time-disable-display)
      (emms-mode-line-cycle 1)))
  ;; Package settings: jabber
  (use-package jabber
    ;; :disabled t
    :defer t
    :config
    (setq jabber-vcard-avatars-retrieve nil
          jabber-roster-show-title nil
          jabber-roster-show-bindings nil
          jabber-show-offline-contacts nil
          jabber-show-resources nil
          jabber-sort-order nil))
  ;; Package settings: dired-filetype-face
  (use-package dired-filetype-face
    ;; :defer t
    :config
    (eval-after-load 'dired '(progn (require 'dired-filetype-face))))

  (use-package pcre2el
    :ensure t
    :config
    (pcre-mode)
    )

  (setq romanian-holidays
      '((holiday-fixed 1 1 "Anul nou")
        (holiday-fixed 1 2 "A doua zi de anul nou")
        (holiday-greek-orthodox-easter)
        (holiday-fixed 5 1 "Ziua muncii")
        (holiday-fixed 5 31 "Prima zi de Rusalii")
        (holiday-fixed 6 1 "A doua zi de Rusalii")
        (holiday-fixed 8 15 "Adormirea Maicii Domnului")
        (holiday-fixed 11 30 "Sfantul apostol Andrei")
        (holiday-fixed 12 1 "Ziua nationala")
        (holiday-fixed 12 25 "Prima zi de Craciun")
        (holiday-fixed 12 26 "A doua zi de Craciun")
        ))

  (setq calendar-holidays
        (append romanian-holidays
                ;; holiday-general-holidays
                ;; holiday-other-holidays
                ;; holiday-local-holidays
                ))

  (setq calendar-location-name "Cluj-Napca, RO"
        calendar-latitude 46
        calendar-longitude 23
        calendar-date-style 'european
        calendar-mark-holidays-flag t
        calendar-week-start-day 1
        calendar-mark-diary-entries-flag nil
        calendar-day-name-array
        ["duminică" "luni" "marți" "miercuri" "joi"
         "vineri" "sâmbătă"]
        calendar-month-name-array
        ["ianuarie" "februarie" "martie" "aprilie" "mai"
         "iunie" "iulie" "august" "septembrie"
         "octombie" "noiembrie" "decembrie"])


  ;; Global keys
  (global-set-key (kbd "M-SPC") 'cycle-spacing)
  (global-set-key (kbd "C-c c") 'comment-or-uncomment-line-or-region)
  (global-set-key (kbd "C-x C-b") 'ibuffer)

  ;; Dired keys
  (define-key dired-mode-map (kbd "q") 'kill-this-buffer)
  (define-key dired-mode-map "a" 'dired-up-directory)

  ;; (setq-default dotspacemacs-configuration-layers '((ibuffer :variables ibuffer-group-buffers-by 'projects)))

  (use-package forge
    :after magit
    :config
    (add-to-list 'forge-alist '("gitlab.eurofunk.com" "gitlab.eurofunk.com/api/v4" "gitlab.eurofunk.com" forge-gitlab-repository))
    )

  ;; (require 'lsp-java)
  ;; (add-hook 'java-mode-hook #'lsp)

  ;; (forge-pull "2019-03-01")

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("eae43024404a1e3c4ea853a9cf7f6f2ad5f091d17234ec3478a23591f25802eb" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (prodigy selectric-mode closql emacsql-sqlite transient lv emacsql forge dap-mode lsp-ui company-lsp lsp-java exwm ansible treepy graphql faff-theme ht org-mime counsel-tramp ghub let-alist all-the-icons memoize font-lock+ dired-icon treemacs pfuture bookmark+ org-category-capture dired-du dired+ restclient-helm ob-restclient ob-http company-restclient restclient know-your-http-well dockerfile-mode docker tablist docker-tramp helm-flx helm-company flyspell-correct-helm ace-jump-helm-line yaml-mode ob-elixir yapfify winum wgrep uuidgen unfill smex py-isort spinner org-projectile log4e gntp ng2-mode mwim lorem-ipsum livid-mode json-snatcher json-reformat fsm insert-shebang hl-todo parent-mode git-gutter-fringe+ fringe-helper git-gutter+ git-gutter fuzzy flyspell-correct-ivy pos-tip flycheck-credo flx evil-visual-mark-mode evil-unimpaired evil-magit evil-lisp-state evil-indent-plus goto-chg undo-tree diminish web-completion-data dash-functional tern color-identifiers-mode bind-map anzu pythonic f pkg-info epl link-hint dumb-jump typescript-mode ivy-hydra csv-mode restart-emacs git-link multiple-cursors async ranger evil-ediff swiper flyspell-correct avy pug-mode auto-compile packed auto-complete simple-httpd orgit org flycheck-mix company-shell yasnippet skewer-mode ws-butler request git-gutter-fringe eshell-z counsel-projectile tide hydra skype meghanada alchemist counsel alert xterm-color spaceline org-download help-fns+ evil-mc column-enforce-mode iedit highlight elixir-mode projectile with-editor ivy persp-mode live-py-mode hide-comnt eyebrowse helm-core magit-popup dired-filetype-face emacs-eclim web-mode web-beautify w3m toc-org tagedit sql-indent smeargle slim-mode shell-pop scss-mode sass-mode rainbow-mode rainbow-identifiers pyvenv pytest pyenv-mode pip-requirements org-repo-todo org-present org-pomodoro org-plus-contrib org-bullets multi-term mmm-mode markdown-toc markdown-mode magit-gitflow magit less-css-mode json-mode js2-refactor js2-mode js-doc jade-mode jabber hy-mode htmlize helm-pydoc helm-pt helm-gitignore helm-flyspell helm-emms helm-css-scss helm-c-yasnippet haml-mode gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-commit gh-md flycheck-pos-tip flycheck fish-mode evil-org eshell-prompt-extras esh-help emms-mode-line-cycle emms emmet-mode diff-hl cython-mode company-web company-tern company-statistics company-quickhelp company-auctex company-anaconda company coffee-mode auto-yasnippet auctex anaconda-mode ac-ispell window-numbering volatile-highlights vi-tilde-fringe spray smooth-scrolling smartparens rainbow-delimiters powerline popwin popup pcre2el paradox page-break-lines open-junk-file neotree move-text macrostep linum-relative leuven-theme info+ indent-guide ido-vertical-mode hungry-delete highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-descbinds helm-ag helm google-translate golden-ratio flx-ido fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-matchit evil-jumper evil-indent-textobject evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu elisp-slime-nav define-word clean-aindent-mode buffer-move auto-highlight-symbol auto-dictionary aggressive-indent adaptive-wrap ace-window ace-link evil-leader evil which-key quelpa package-build use-package bind-key s dash spacemacs-theme)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#DCDCCC" :background "#3F3F3F"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("eae43024404a1e3c4ea853a9cf7f6f2ad5f091d17234ec3478a23591f25802eb" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (all-the-icons memoize typescript-mode magit-popup skewer-mode simple-httpd json-mode json-snatcher json-reformat multiple-cursors js2-mode haml-mode gitignore-mode fringe-helper git-gutter+ git-gutter markdown-mode ghub closql emacsql-sqlite emacsql treepy graphql pos-tip transient with-editor web-completion-data dash-functional tern know-your-http-well auto-complete tablist git-commit org-category-capture alert log4e gntp yasnippet flycheck jinja2-mode company-ansible ansible-doc ansible wgrep smex ivy-hydra counsel-projectile ibuffer-projectile dash lv restclient lsp-java lsp-mode ht company org-plus-contrib prettier-js swiper avy counsel ivy projectile magit hydra helm helm-core org-jira zenburn-theme yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify w3m volatile-highlights vi-tilde-fringe uuidgen use-package unfill toc-org tide tagedit spaceline smeargle slim-mode shell-pop selectric-mode scss-mode sass-mode restclient-helm restart-emacs rainbow-mode rainbow-identifiers rainbow-delimiters pug-mode popwin persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets open-junk-file ob-restclient ob-http neotree mwim multi-term move-text mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode linum-relative link-hint less-css-mode js2-refactor js-doc insert-shebang indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy forge flycheck-pos-tip flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav dumb-jump dockerfile-mode docker dired-filetype-face dired-du diminish diff-hl define-word counsel-tramp company-web company-tern company-statistics company-shell company-restclient column-enforce-mode color-identifiers-mode coffee-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#DCDCCC" :background "#3F3F3F"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
