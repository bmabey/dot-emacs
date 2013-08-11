(ensure-packages-installed
 '(starter-kit-lisp
    clojure-mode
    midje-mode
    clojure-test-mode
    clojurescript-mode
    nrepl
    nrepl-ritz
    auto-complete
    ac-nrepl
    clojure-cheatsheet
    ;; slime
    ;; slime-repl
    ;; durendal
    highlight-parentheses
    ))


(require 'starter-kit-lisp)
(require 'highlight-parentheses)

(add-to-list 'load-path "~/.emacs.d/vendor/nrepl-inspect")
(require 'nrepl-inspect)

(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)


(add-hook 'nrepl-mode-hook 'highlight-parentheses-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)

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

;; ansi color for midje autotest.. via https://github.com/marick/Midje/issues/222
(defun nrepl-emit-output (buffer string &optional bol)
  "Using BUFFER, emit STRING.
If BOL is non-nil, emit at the beginning of the line."
  (with-current-buffer buffer
    (nrepl-emit-output-at-pos buffer string nrepl-input-start-mark bol)
    (ansi-color-apply-on-region (marker-position nrepl-output-start) (point-max))))


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

(define-key clojure-mode-map (kbd "s-:") 'clj-toggle-keyword-string)
