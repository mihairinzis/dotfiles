;;; hydras.el --- Personal configuration on top of prelude

;;; Commentary:
;;;

;;; Code:
;; hydras

(use-package hydra
  :ensure t
  :defer t
  :config
  (defhydra hydra-global-org (:color blue
                                     :hint nil)
    "
Timer^^        ^Clock^         ^Capture^
--------------------------------------------------
s_t_art        _w_ clock in    _c_apture
 _s_top        _o_ clock out   _l_ast capture
_r_eset        _j_ clock goto
_p_rint
"
    ("t" org-timer-start)
    ("s" org-timer-stop)
    ;; Need to be at timer
    ("r" org-timer-set-timer)
    ;; Print timer value to buffer
    ("p" org-timer)
    ("w" (org-clock-in '(4)))
    ("o" org-clock-out)
    ;; Visit the clocked task from any buffer
    ("j" org-clock-goto)
    ("c" org-capture)
    ("l" org-capture-goto-last-stored))
  (global-set-key [f11] 'hydra-global-org/body)

  (defhydra hydra-helm (:hint nil :color pink)
    "
                                                                          ╭──────┐
   Navigation   Other  Sources     Mark             Do             Help   │ Helm │
  ╭───────────────────────────────────────────────────────────────────────┴──────╯
        ^_k_^         _K_       _p_   [_m_] mark         [_v_] view         [_H_] helm help
        ^^↑^^         ^↑^       ^↑^   [_t_] toggle all   [_d_] delete       [_s_] source help
    _h_ ←   → _l_     _c_       ^ ^   [_u_] unmark all   [_f_] follow: %(helm-attr 'follow)
        ^^↓^^         ^↓^       ^↓^    ^ ^               [_y_] yank selection
        ^_j_^         _J_       _n_    ^ ^               [_w_] toggle windows
  --------------------------------------------------------------------------------
        "
    ("<tab>" helm-keyboard-quit "back" :exit t)
    ("<escape>" nil "quit")
    ("\\" (insert "\\") "\\" :color blue)
    ("h" helm-beginning-of-buffer)
    ("j" helm-next-line)
    ("k" helm-previous-line)
    ("l" helm-end-of-buffer)
    ("g" helm-beginning-of-buffer)
    ("G" helm-end-of-buffer)
    ("n" helm-next-source)
    ("p" helm-previous-source)
    ("K" helm-scroll-other-window-down)
    ("J" helm-scroll-other-window)
    ("c" helm-recenter-top-bottom-other-window)
    ("m" helm-toggle-visible-mark)
    ("t" helm-toggle-all-marks)
    ("u" helm-unmark-all)
    ("H" helm-help)
    ("s" helm-buffer-help)
    ("v" helm-execute-persistent-action)
    ("d" helm-persistent-delete-marked)
    ("y" helm-yank-selection)
    ("w" helm-toggle-resplit-and-swap-windows)
    ("f" helm-follow-mode))
  (define-key helm-map (kbd "C-o") 'hydra-helm/body)

  ;; (defhydra hydra-yank-pop ()
  ;;   "yank"
  ;;   ("C-y" yank nil)
  ;;   ("M-y" yank-pop nil)
  ;;   ("y" (yank-pop 1) "next")
  ;;   ("Y" (yank-pop -1) "prev")
  ;;   ("l" helm-show-kill-ring "list" :color blue))   ; or browse-kill-ring
  ;; (global-set-key (kbd "M-y") #'hydra-yank-pop/yank-pop)
  ;; (global-set-key (kbd "C-y") #'hydra-yank-pop/yank)

  ;; (defhydra hydra-goto-line (goto-map ""
  ;;                                     :pre (linum-mode 1)
  ;;                                     :post (linum-mode -1))
  ;;   "goto-line"
  ;;   ("g" goto-line "go")
  ;;   ("m" set-mark-command "mark" :bind nil)
  ;;   ("q" nil "quit"))
  ;; (global-set-key (kbd "M-g M-g") #'hydra-goto-line/body)


  (key-chord-define-global
   "zz"
   (defhydra hydra-zoom ()
     "zoom"
     ("=" text-scale-increase "in")
     ("-" text-scale-decrease "out"))))

;;; hydras.el ends here
