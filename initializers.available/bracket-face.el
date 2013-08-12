;;; bracket-face.el --- parenface for other brackets
;;; via https://github.com/skeeto/.emacs.d/blob/master/etc/bracket-face.el

;;; Code:

(defvar bracket-face 'bracket-face)

(defface bracket-face
    '((((class color))
       (:foreground "Gray60")))
  "Face for displaying a bracket."
  :group 'faces)

(defmacro bracket-face (keywords)
  "Generate a lambda expression for use in a hook."
  `(lambda ()
     (let* ((regexp "\\[\\|\\]\\|{\\|}")
            (match (assoc regexp ,keywords)))
       (unless (eq (cdr match) bracket-face)
         (setq ,keywords (cons (cons regexp bracket-face) ,keywords))))))

(add-hook 'scheme-mode-hook (bracket-face scheme-font-lock-keywords-2))
(add-hook 'lisp-mode-hook (bracket-face lisp-font-lock-keywords-2))
(add-hook 'emacs-lisp-mode-hook (bracket-face lisp-font-lock-keywords-2))
(add-hook 'clojure-mode-hook (bracket-face clojure-font-lock-keywords))

(provide 'bracket-face)

;;; bracket-face.el ends here
