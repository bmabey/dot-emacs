(add-to-list 'load-path user-emacs-directory)

;; old starter kit legacy code...
;;TODO: remove dependence on the following lines and rm -rf corresponding files...
(setq dotfiles-dir user-emacs-directory)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(load autoload-file)
;;;;


(require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defun ensure-packages-installed (packages)
  (dolist (p packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; TODO: Switch to the package once a release is made... right now we rely on unreleased changes
;;(ensure-packages-installed
;; '(starter-kit starter-kit-bindings starter-kit-eshell))

;; TODO: remove when new starter kit package is available
(ensure-packages-installed
 '(paredit idle-highlight-mode find-file-in-project smex ido-ubiquitous magit))
(add-to-list 'load-path (concat user-emacs-directory "vendor/emacs-starter-kit"))
(add-to-list 'load-path (concat user-emacs-directory "vendor/emacs-starter-kit/modules"))
(mapc 'require '(starter-kit starter-kit-bindings starter-kit-eshell))
;;;

(setq custom-file (concat esk-user-dir "/custom.el"))

(load (concat dotfiles-dir "initializers.el"))
(ini-load-all)


;; TODO: figure this out so I can use TAB with AC and yas...
;; http://iany.me/2012/03/fix-tab-binding-for-yasnippet-and-auto-complete/
;; (custom-set-variables
;;  '(ac-trigger-key "TAB")
;;  '(ac-auto-start nil)
;;  '(ac-use-menu-map t))

;; (defun iy-tab-noconflict ()
;;   (let ((command (key-binding [tab]))) ; remember command
;;     (local-unset-key [tab]) ; unset from (kbd "<tab>")
;;     (local-set-key (kbd "TAB") command))) ; bind to (kbd "TAB")

;; (add-hook 'ruby-mode-hook 'iy-ac-tab-noconflict)
;; (add-hook 'markdown-mode-hook 'iy-ac-tab-noconflict)
;; (add-hook 'org-mode-hook 'iy-ac-tab-noconflict)
;; (add-hook 'clojure-mode-hook 'iy-ac-tab-noconflict)

(server-start)
