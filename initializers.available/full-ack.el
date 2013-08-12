(ensure-packages-installed
 '(full-ack))

(defun ack-here ()
  "Run ack from default-directory of the current buffer"
  (interactive)
  (require 'full-ack)
  (ack-run default-directory t (ack-read t)))

(global-set-key [(shift super a)] 'ack)
