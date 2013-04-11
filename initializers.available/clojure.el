(ensure-packages-installed
 '(starter-kit-lisp
    clojure-mode
    midje-mode
    clojure-test-mode
    clojurescript-mode
    nrepl
    nrepl-ritz
    ;; slime
    ;; slime-repl
    ;; durendal
    highlight-parentheses
    ))

(require 'starter-kit-lisp)
(require 'highlight-parentheses)

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



(defun clojurescript-repl ()
 (interactive)
 (run-lisp "lein trampoline cljsbuild repl-listen"))

;; (add-hook 'clojure-mode-hook 'durendal-enable-auto-compile)
;; (add-hook 'slime-repl-mode-hook 'durendal-slime-repl-paredit)
;; (add-hook 'sldb-mode-hook 'durendal-dim-sldb-font-lock)
;; (add-hook 'slime-compilation-finished-hook 'durendal-hide-successful-compile)

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
