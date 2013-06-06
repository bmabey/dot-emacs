(ensure-packages-installed
  '(;;starter-kit-ruby - use this and remove vendor version when new version has been pushed to marmalade..
       ruby-compilation
       inf-ruby
        ))

(require 'starter-kit-ruby)
(require 'rcodetools) ;; provides the xmp filter (http://emacsblog.org/2007/07/21/package-faves-rcodetools/)

(eval-after-load 'ruby-mode
  '(progn
     (require 'rspec-mode)
     (require 'ruby-electric)

     (add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))

     (defun ruby-eval-region-or-last-sexp ()
       "if region active, evaluate it. otherwise last sexp"
       (interactive)
       (if mark-active
           (let (deactivate-mark)
             (ruby-send-region (region-beginning) (region-end)))
         (ruby-send-last-sexp)))

     
     (define-key ruby-mode-map (kbd "s-r") 'xmp)
     (define-key ruby-mode-map (kbd "C-i") 'ruby-eval-region-or-last-sexp)
     (define-key ruby-mode-map (kbd "C-I") 'ruby-send-definition)
     (define-key ruby-mode-map (kbd "C-c l") 'ruby-send-line)
     (define-key ruby-mode-map (kbd "C-c C-e") 'ruby-send-last-sexp)
     (define-key ruby-mode-map (kbd "C-c C-d") 'ruby-send-definition)
     (define-key ruby-mode-map (kbd "TAB") nil)

     (defun bundler-find-Gemfile-root (&optional directory)
       "Finds the Gemfile of the project by walking the directory tree until it finds a Gemfile."
       (let ((directory (file-name-as-directory (or directory default-directory))))
         (cond ((rspec-root-directory-p directory) nil)
               ((file-exists-p (concat directory "Gemfile")) directory)
               (t (bundler-find-Gemfile-root (file-name-directory (directory-file-name directory)))))))

     (defun bundler/shell-command-to-string (command on-error)
       "Execute shell command COMMAND and return its output as a string.
If non-zero exit, call on-error lambda with exitstatus as argument"
       (let* (exitstatus
              (output (with-output-to-string
                        (with-current-buffer
                            standard-output
                          (setq exitstatus (call-process shell-file-name nil t nil shell-command-switch command))))))
         (unless (= 0 exitstatus)
           (funcall on-error exitstatus output))
         output))

     (defun bundler-gems-list ()
       "Lists gems used by bundler"
       (let ((bundler-root (bundler-find-Gemfile-root)))
         (when (not bundler-root)
           (message  "Can't find bundler Gemfile")
           (signal 'quit nil ))
         (let* ((command (format "cd %S && bundle list" bundler-root))
                (output (bundler/shell-command-to-string command
                                                         (lambda (exitstatus output) (error "%S returned exit status %d, output:\n%s" command exitstatus output))))
                (lines (split-string output "\n"))
                (gem-lines (rest lines))
                (gems (mapcar (lambda (line)
                                (replace-regexp-in-string "^ *\\* *\\(.*?\\) (.+) *$" "\\1" line))
                              gem-lines)))
           gems)))

     (defun bundler-open-gem (gem-name)
       (interactive (bundler-prompt-for-gem))
       (let ((gem-path (shell-command-to-string
                        (format "cd %S && bundle show %S"
                                (bundler-find-Gemfile-root)
                                gem-name))))
         (dired (format "%s/" (replace-regexp-in-string "\n*$" "" gem-path)))))

     (defun bundler-prompt-for-gem ()
       (let ((response (ido-completing-read "Gem: "
                                            (bundler-gems-list))))
         (when response (list response))))))
