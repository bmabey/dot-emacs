(ensure-packages-installed
 '(evil
   surround ;; evil-surround
   evil-numbers
   ;;evil-paredit
   ))

(require 'evil)
(require 'surround)
(evil-mode 1)
(global-surround-mode 1)

(global-set-key (kbd "s-j") 'evil-normal-state)

(define-key evil-insert-state-map "\C-y" nil)
(define-key evil-insert-state-map "\C-e" nil)
(define-key evil-insert-state-map "\C-k" nil)
(define-key evil-motion-state-map "\C-i" nil)
(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "M-.") nil)


(global-set-key (kbd "C-]") 'evil-find-char)
(global-set-key (kbd "C-M-]") 'evil-find-char-backward)

(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
;;(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

;; Making the most of RET and SPC (via http://www.emacswiki.org/emacs/Evil#toc11)
;; It is common for Emacs modes like these to define key bindings for RET and SPC. Since these are motion commands, Evil ;; places its key bindings for these in evil-motion-state-map. However, these commands are fairly worthless to a ;; ;; ;; seasoned Vim user, since they do the same thing as j and l commands. Thus it is useful to remove them from
;; evil-motion-state-map so as when modes define them, RET and SPC bindings are available directly.

(defun evil/move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))
(evil/move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(evil/move-key evil-motion-state-map evil-normal-state-map " ")