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

(cond
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-frame-font "DejaVu Sans Mono-9"))
 ((find-font (font-spec :name "inconsolata"))
  (set-frame-font "inconsolata-9"))
 ((find-font (font-spec :name "Consolas"))
  (set-frame-font "Consolas-9"))
 ((find-font (font-spec :name "Lucida Console"))
  (set-frame-font "Lucida Console-9"))
 ((find-font (font-spec :name "courier"))
  (set-frame-font "courier-9")))

;; (set-face-attribute 'mode-line nil :height 60)
;; (set-face-attribute 'default nil :height 100)

;; make shell colorful
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; powerline
(require 'powerline)
(powerline-default-theme)

;;; appearance.el ends here
