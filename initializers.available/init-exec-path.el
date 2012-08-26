;; Taken from https://github.com/purcell/emacs.d

(setq *is-a-mac* (eq system-type 'darwin))
(defun string-rtrim (str)
   "Remove trailing whitespace from `STR'."
     (replace-regexp-in-string "[ \t\n]*$" "" str))

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (string-rtrim (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when (and *is-a-mac* window-system)
  (add-hook 'after-init-hook 'set-exec-path-from-shell-PATH))
