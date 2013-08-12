
(defun yh/path (&optional root)
  (let* ((root (or root (textmate-project-root)))
         (filename (buffer-file-name))
         (local-filename (if root
                             (replace-regexp-in-string (format "^%s" (regexp-quote root)) "./" filename)
                           filename)))
    (message "%s" local-filename)))

(defun yh/path-with-line (&optional root)
  (message "%s" (format "%s:%d"
                        (tim/path root)
                        (line-number-at-pos))))

(defun yank-path-with-line ()
  (interactive)
  "Yank (to clipboard) the current location, in /path/to/file:line format"
  (let ((location (yh/path-with-line)))
    (message "%s" location)
    (kill-new location)))

(defun yank-annotated ()
  "Yanks the region, puts a filename and line numbers. Lots of fun"
  (interactive)
  (let* ((start-pos (save-excursion (goto-char (region-beginning))
                                    (beginning-of-line)
                                    (point)))
         (end-pos (save-excursion (goto-char (region-end))
                                  (end-of-line)
                                  (point)))
         (start-line (line-number-at-pos (region-beginning)))
         (content (buffer-substring start-pos end-pos))
         (filename buffer-file-name)
         (r (with-temp-buffer
               (insert content)
               (newline)
               (while (line-move -1 t)
                 (beginning-of-line)
                 (insert (format "%4d | " (+ (line-number-at-pos) start-line -1))))

               (goto-char (point-min))
               (insert filename)
               (newline)
               (newline)
               (buffer-string))))
    ;; (message "%s %s %d %d %d" filename content start-pos end-pos start-line)
    (message "%s" r)
    (kill-new r)
    (deactivate-mark)))
