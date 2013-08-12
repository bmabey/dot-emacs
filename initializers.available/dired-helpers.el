(defun dired-create-file (file)
  "Create an empty file called FILE."
  (interactive
   (list (read-file-name "Touch file: " (dired-current-directory))))
  (let ((expanded (expand-file-name file)))
    (message "%s" (shell-command-to-string (format "%s %S" dired-touch-program expanded)))
    (dired-add-file expanded)
    (dired-move-to-filename)))

(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "F") 'dired-create-file))
