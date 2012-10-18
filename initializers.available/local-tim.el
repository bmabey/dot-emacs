(defmacro tim-apply-key-remapping (source destination)
  `(global-set-key (kbd ,source) (lambda () (interactive) (setq unread-command-events (listify-key-sequence (kbd ,destination))))))

(tim-apply-key-remapping "s-o" "C-x")
(tim-apply-key-remapping "C-x s-e" "C-x C-e")
(tim-apply-key-remapping "C-x s-f" "C-x C-f")

(tim-apply-key-remapping "s-u" "C-c")
(tim-apply-key-remapping "C-c s-r" "C-c C-r")
(tim-apply-key-remapping "C-c s-f" "C-c C-f")
(tim-apply-key-remapping "C-c s-b" "C-c C-b")
(tim-apply-key-remapping "C-c s-e" "C-c C-e")
(tim-apply-key-remapping "C-c s-d" "C-c C-d")
(global-set-key (kbd "C-c s-u") 'revert-buffer)

(tim-apply-key-remapping "s-i" "C-c")

(global-set-key (kbd "s-b") 'switch-to-buffer)


;; (defun decrease-font-size ()
;;   "Decrease the font size"
;;   (interactive)
;;   (text-scale-adjust -1)
;;   )

;; (defun increase-font-size ()
;;   "Increase the font size"
;;   (interactive)
;;   (text-scale-adjust 1))

;; (global-set-key (kbd "s-=") 'increase-font-size)
;; (global-set-key (kbd "s--") 'decrease-font-size)

(global-set-key (kbd "s-'") 'other-window)

(defun kill-buffer-and-delete-window ()
  (interactive)
  (kill-this-buffer)
  (unless (= 1 (count-windows)) (delete-window)))

(global-set-key (kbd "C-x s-0") 'kill-buffer-and-delete-window)
(global-set-key [(control super k)] 'kill-buffer-and-delete-window)
(global-set-key [(control super clear)] 'kill-buffer-and-delete-window) ;; for some reason... OS X sends 'clear' instead of k with certain modifiers
(global-set-key (kbd "<C-s-268632075>") 'kill-buffer-and-delete-window) ;; and in emacs 24.1... it sends this. LAME



(defun ns-copy-including-secondary ()
  (interactive)
  (let ((deactivate-mark nil))
    (call-interactively 'kill-ring-save)
    (ns-store-cut-buffer-internal 'SECONDARY
                                  (buffer-substring (point) (mark t)))))
;; (defun split-window-and-switch-to-previous-buffer)

(defun swap-region-around-text ()
  "swaps region around specified text"
  (interactive)
  ;; TODO
  )

(setq ispell-extra-args '("--sug-mode=ultra"))

;;(global-set-key (kbd "C-h") 'delete-backward-char)
(put 'narrow-to-region 'disabled nil)
(show-paren-mode 1)
(global-visual-line-mode)
(global-hl-line-mode 1)


