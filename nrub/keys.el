;; Code formatting
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Searching
(global-set-key (kbd "C-c s") 'find-grep-dired) ; Find string in files

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Quicker way to use macros
(global-set-key [f5] 'call-last-kbd-macro)

;; Select All
(global-set-key "\C-c\C-a" 'mark-whole-buffer)
