;;; appearance.el --- Appearance configuration

;;; Commentary:
;;;

;;; Code:

;; Turn off the scroll-bar
(scroll-bar-mode -1)
;; ;; Linum (line numbering)
;; (require 'linum)
;; (global-linum-mode)
;; Push the mouse out of the way on cursor approach
(mouse-avoidance-mode 'cat-and-mouse)

;; make cursor slimmer
;; (setq-default cursor-type 'bar)
;; blink instead of beeping
(setq visible-bell t)
;; show pics
(setq auto-image-file-mode 1)
;; auto switch doc page when scrolling
(setq doc-view-continuous t)

;; set font
(cond
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-frame-font "DejaVu Sans Mono-9"))
 ((find-font (font-spec :name "Monospace"))
  (set-frame-font "Monospace-11"))
 ((find-font (font-spec :name "inconsolata"))
  (set-frame-font "inconsolata-10"))
 ((find-font (font-spec :name "Consolas"))
  (set-frame-font "Consolas-10"))
 ((find-font (font-spec :name "Lucida Console"))
  (set-frame-font "Lucida Console-10"))
 ((find-font (font-spec :name "courier"))
  (set-frame-font "courier-10")))

;; (set-face-attribute 'mode-line nil :height 60)
;; (set-face-attribute 'default nil :height 100)

;; make shell colorful
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; make identifier colorful
(use-package color-identifiers-mode
  :ensure t
  :defer 5
  :init
  (progn
    (add-hook 'after-init-hook 'global-color-identifiers-mode)))

(use-package powerline
  :ensure t
  :init
  (powerline-default-theme))

(use-package golden-ratio
  :disabled t
  :ensure t
  :diminish golden-ratio-mode
  :init
  (golden-ratio-mode 1)
  :config
  (setq golden-ratio-exclude-modes
        '("ediff-mode" "calendar-mode" "guide-key-mode"
          "sunshine-mode" "hydra-mode" "fundamental-mode")
        golden-ratio-exclude-buffer-names
        '(" *guide-key*" " *popwin-dummy*" " *Sunshine*" " *NeoTree*")))

;;; appearance.el ends here
