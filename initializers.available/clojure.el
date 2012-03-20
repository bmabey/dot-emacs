(ensure-packages-installed
  '(elisp-slime-nav ;; remove once we can add starter-kit back in...
    ;; starter-kit-lisp ;; comment in once new starter-kit has been pushed to marmalade
    clojure-mode midje-mode clojure-test-mode slime
    slime-repl
    ;;durendal
    highlight-parentheses))

(require 'starter-kit-lisp)
(require 'highlight-parentheses)

(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)
(add-hook 'slime-repl-mode-hook 'highlight-parentheses-mode)
(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

;;(require 'durendal)
;;(add-hook 'clojure-mode-hook 'durendal-enable-auto-compile)
;;(add-hook 'slime-repl-mode-hook 'durendal-slime-repl-paredit)
;;(add-hook 'sldb-mode-hook 'durendal-dim-sldb-font-lock)
;;(add-hook 'slime-compilation-finished-hook 'durendal-hide-successful-compile)

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

                               )))
