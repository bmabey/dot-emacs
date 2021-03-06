(ensure-packages-installed
 '(clojure-mode
    midje-mode
    clojure-test-mode
    nrepl
    nrepl-ritz
    auto-complete
    ac-nrepl
    clojure-cheatsheet
    parenface
    highlight-parentheses))


;; general lisp improvements
(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

(require 'parenface)
(set-face-foreground 'paren-face "Gray40")

;; clojure-mode

;; not using the hook because of a bug that required me to call clojure-mode twice...
;; (add-hook 'clojure-mode-hook (paren-face-add-support clojure-font-lock-keywords))
(dolist (mode '(clojure)) ;; nrepl... didn't seem to work...
(let ((mode-name (intern (concat (symbol-name mode) "-mode"))))
  (font-lock-add-keywords mode-name '(("(\\|)" . 'paren-face)
                                      ("\\[\\|\\]\\|{\\|}" . 'bracket-face)))))

(require 'highlight-parentheses)

(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
;;(add-hook 'clojure-mode-hook 'evil-paredit-mode)

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "λ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "ƒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∈")
                               nil))))))

(put 'def-atomic-model 'clojure-backtracking-indent '(4 4 (2)))
(add-hook 'clojure-mode-hook (lambda ()
                               (define-clojure-indent
                                 ;; thread-expr macros
                                 (for-> 1)
                                 (when-> 1)
                                 (when-not-> 1)
                                 (let-> 1)
                                 (binding-> 1)
                                 (when-let-> 1)
                                 (if-> 1)
                                 (if-not-> 1)
                                 (arg-> 1)
                                 (let-with-arg-> 1)
                                 (apply-> 1)
                                 (apply-map-> 1)
                                 (for->> 1)
                                 (when->> 1)
                                 (when-not->> 1)
                                 (let->> 1)
                                 (binding->> 1)
                                 (when-let->> 1)
                                 (if->> 1)
                                 (if-not->> 1)
                                 (arg->> 1)
                                 (let-with-arg->> 1)
                                 (apply->> 1)
                                 (apply-map->> 1)

                                 ;; predict project
                                 (def-atomic-model 2)
                                 (when-attribute 2)

                                 ;; stuffs
                                 (when-let-multi 1)

                                 )))
;; nrepl

(add-to-list 'load-path "~/.emacs.d/vendor/nrepl-inspect")
(require 'nrepl-inspect)

(add-hook 'nrepl-mode-hook 'highlight-parentheses-mode)
;; (add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)

(setq nrepl-popup-stacktraces-in-repl t)

(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))

;;    Make C-c C-z switch to the *nrepl* buffer in the current window:
(add-to-list 'same-window-buffer-names "*nrepl*")

;; Enabling CamelCase support for editing commands (like forward-word, backward-word, etc) in nREPL
;; is quite useful since we often have to deal with Java class and method names. The built-in Emacs
;; minor mode subword-mode provides such functionality:
(add-hook 'nrepl-mode-hook 'subword-mode)

;; specify the print length to be 100 to stop infinite sequences killing things.
(defun nrepl-set-print-length ()
  (nrepl-send-string-sync "(set! *print-length* 100)" "clojure.core"))

(add-hook 'nrepl-connected-hook 'nrepl-set-print-length)


;; trying out ac-repl-compliment
;; (add-to-list 'load-path "~/.emacs.d/vendor/ac-nrepl-compliment")
;; (require 'ac-nrepl-compliment)
;; 
;; (add-hook 'nrepl-mode-hook 'ac-nrepl-compliment-setup)
;; (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-compliment-setup)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'nrepl-mode))
;; 
;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (setq completion-at-point-functions '(auto-complete)))
;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; 
;; (add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-compliment-popup-doc)

;;Auto Complete
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))


(add-hook 'nrepl-mode-hook 'auto-complete-mode)
(add-hook 'nrepl-interaction-mode-hook 'auto-complete-mode)

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)



;; helpers

;; http://blog.jayfields.com/2013/05/emacs-lisp-toggle-between-clojure.html

(defun char-at-point ()
  (interactive)
  (buffer-substring-no-properties (point) (+ 1 (point))))

(defun clj-string-name (s)
  (substring s 1 -1))

(defun clj-keyword-name (s)
  (substring s 1))

(defun clj-delete-and-extract-sexp ()
  (let* ((begin (point)))
    (forward-sexp)
    (let* ((result (buffer-substring-no-properties begin (point))))
      (delete-region begin (point))
      result)))

(defun clj-toggle-keyword-string ()
  (interactive)
  (save-excursion
    (if (equal 1 (point))
        (message "beginning of file reached, this was probably a mistake.")
      (cond ((equal "\"" (char-at-point))
             (insert ":" (clj-string-name (clj-delete-and-extract-sexp))))
            ((equal ":" (char-at-point))
             (insert "\"" (clj-keyword-name (clj-delete-and-extract-sexp)) "\""))
            (t (progn
                 (backward-char)
                 (clj-toggle-keyword-string)))))))

(defun nrepl-reset ()
  (interactive)
  (set-buffer "*nrepl*")
  (goto-char (point-max))
  (insert "(user/reset)")
  (nrepl-return))

(defun nrepl-hard-reset (connection-buffer)
  "Close the nrepl connection for CONNECTION-BUFFER and jacks in again."
  (interactive (list (nrepl-current-connection-buffer)))
  (nrepl-close connection-buffer)
  (nrepl-jack-in))

;; key bindings

(define-key clojure-mode-map (kbd "s-:") 'clj-toggle-keyword-string)
(define-key clojure-mode-map (kbd "s-K") 'nrepl-close-ancilliary-buffers)

(define-key clojure-mode-map (kbd "s-R") 'nrepl-reset)
(define-key clojure-mode-map (kbd "s-I") 'nrepl-inspect)
(define-key clojure-mode-map (kbd "s-p") 'ac-nrepl-popup-doc)
(define-key clojure-mode-map (kbd "s-P") 'nrepl-doc)
;; (define-key clojure-mode-map (kbd "C-s-r") 'nrepl-hard-reset)
