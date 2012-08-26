(ensure-packages-installed
 '(haskell-mode ghc))

;; Largley inspired from http://sritchie.github.com/2011/09/25/haskell-in-emacs.html
(defun my-haskell-mode-hook ()
  "ghc-init, plus autocompletion and paredit."
  ;; (local-set-key "\C-cl" 'hs-lint)
  (setq ac-sources
        (append '(ac-source-yasnippet
                  ac-source-abbrev
                  ac-source-words-in-buffer
                  my/ac-source-haskell)
                ac-sources))
  (dolist (x '(haskell literate-haskell))
    (add-hook
     (intern (concat (symbol-name x)
                     "-mode-hook"))
     (lambda ()
       (turn-on-haskell-doc-mode)
       (turn-on-haskell-indentation)
       (ghc-init)
       (flymake-mode)))))

(autoload 'ghc-init "ghc" nil t)
(my-haskell-mode-hook)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
;; Ignore compiled Haskell files in filename completions
;; (add-to-list 'completion-ignored-extensions ".hi")
