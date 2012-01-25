(ensure-packages-installed
 '(
color-theme-cobalt
ace-jump-mode
))

;;(require 'color-theme-blackboard)
;;(require 'color-theme)
;;(require 'color-theme-cobalt)
;;(color-theme-cobalt)

(color-theme-ir-black)

(icomplete-mode t)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(blink-cursor-mode t)

(setq evil-emacs-state-cursor '("white" box))
(setq evil-insert-state-cursor '("dark orange" bar))
(setq evil-visual-state-cursor '("black" hollow))

(require 'linum)

;; yes, I like paredit on in my REPL
(add-hook 'slime-repl-mode-hook 'paredit-mode)

(idle-highlight-mode f) ;; TODO: fix this.. it doesn't work..

;; gracias a http://www.emacswiki.org/emacs/DeletingWhitespace#toc3
(add-hook 'before-save-hook 'delete-trailing-whitespace)
