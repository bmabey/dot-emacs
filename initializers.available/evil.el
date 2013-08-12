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
