(ensure-packages-installed
 '(
;; color-theme-cobalt
ace-jump-mode
))

;;(require 'color-theme-blackboard)
;;(require 'color-theme)
;;(require 'color-theme-cobalt)
;;(color-theme-cobalt)

;; (color-theme-ir-black)

(icomplete-mode t)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(blink-cursor-mode t)

(setq evil-emacs-state-cursor '("white" box))
(setq evil-insert-state-cursor '("dark orange" bar))
(setq evil-visual-state-cursor '("black" hollow))

(require 'linum)

;; yes, I like paredit on in my REPL
(add-hook 'slime-repl-mode-hook 'paredit-mode)

;; ESK turns on idle-highlight-mode alwyas, and it bugs me...
(defun turn-off-idle-highlight-mode ()
  (idle-highlight-mode f))

(add-hook 'prog-mode-hook 'turn-off-idle-highlight-mode)

;; gracias a http://www.emacswiki.org/emacs/DeletingWhitespace#toc3
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'tramp)
(setq tramp-auto-save-directory '"~/.tramp")
;(setq tramp-chunksize 500) ; use for openbsd
(setq tramp-persistency-file-name "~/.emacs.d/tmp/tramp")
(setq-default fill-column 120)
;; In order to take advantage of ControlMaster (i.e. scpc) and avoid problems caused by ControlPersist you need to
;; patch tramp. (taken from http://lists.gnu.org/archive/html/tramp-devel/2012-03/msg00011.html) Heres how:
;; 1. open up /Applications/Emacs.app/Contents/Resources/lisp/net/tramp-sh.el.gz
;; 2. Search for 'ControlMaster' to find where the tramp-login-args are being defined.
;; 3. Next to the line where it says '("-o" "ControlMaster=yes")'  add: ("-o" "ControlPersist=no")
;; 4. Save your change and run M-x byte-complile-file. Run this on the
;; patched tramp-sh.el.gz file.

(set-exec-path-from-shell-PATH)
