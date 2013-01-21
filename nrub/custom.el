
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex")
 '(ac-auto-show-menu t)
 '(ac-delay 999.0)
 '(ac-expand-on-auto-complete nil)
 '(ac-modes (quote (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode java-mode clojure-mode scala-mode scheme-mode ocaml-mode tuareg-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode ess-mode inferior-ess-mode inferior-ruby-mode)))
 '(ac-quick-help-delay 0.25)
 '(ac-trigger-commands (quote (self-insert-command backward-delete-char)))
 '(ac-trigger-commands-on-completing (quote (delete-backward-char backward-delete-char backward-delete-char-untabify self-insert-command)))
 '(ac-trigger-key nil)
 '(ac-use-menu-map t)
 '(ac-use-quick-help t)
 '(ack-project-root-file-patterns (quote (".project\\'" ".xcodeproj\\'" ".sln\\'" "\\`Project.ede\\'" "\\`.git\\'" "\\`.bzr\\'" "\\`_darcs\\'" "\\`.hg\\'" ".dir-locals" ".emacs-project")))
 '(blink-cursor-mode nil)
 '(css-indent-offset 2)
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(cursor-type (quote bar) t)
 '(default-frame-alist (quote ((vertical-scroll-bars . right) (background-color . "#000000") (background-mode . dark) (cursor-color . "#ffffff") (foreground-color . "#eaeaea") (width . 120) (height . 48))))
 '(erc-autojoin-channels-alist (quote (("freenode.net"))))
 '(erc-autojoin-mode t)
 '(erc-modules (quote (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track)))
 '(evil-cross-lines t)
 '(evil-emacs-state-modes (quote (bookmark-bmenu-mode bookmark-edit-annotation-mode browse-kill-ring-mode compilation-mode completion-list-mode Custom-mode debugger-mode efs-mode ert-results-mode gnus-group-mode gnus-summary-mode jde-javadoc-checker-report-mode mh-folder-mode occur-mode rcirc-mode tar-mode vm-mode vm-summary-mode ibuffer-mode sldb-mode dired-mode magit-commit-mode magit-log-mode magit-stash-mode magit-status-mode magit-log-edit-mode magit-key-mode)))
 '(evil-find-skip-newlines t)
 '(evil-move-cursor-back nil)
 '(evil-regexp-search t)
 '(evil-shift-width 2)
 '(evil-want-C-i-jump nil)
 '(evil-want-C-u-scroll t)
 '(evil-want-fine-undo t)
 '(exec-path (quote ("~/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/usr/local/bin" "/usr/X11/bin" "/usr/local/git/bin" "/Applications/Emacs.app/Contents/MacOS/bin" "/usr/local/texlive/2009/bin/universal-darwin/" "/opt/local/bin")))
 '(ffap-machine-p-known (quote reject))
 '(global-auto-revert-mode t)
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(hl-paren-background-colors nil)
 '(hl-paren-colors (quote ("#ff2244" "#ff7700" "#ffff00" "#00ff00" "#2266ff" "#00aaff" "#ff00ff" "black")))
 '(ibuffer-default-sorting-mode (quote filename/process))
 '(ido-auto-merge-delay-time 60)
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido))
 '(imenu-max-item-length 120)
 '(init-face-from-resources nil)
 '(js2-basic-offset 2)
 '(load-home-init-file t t)
 '(make-backup-files nil)
 '(mouse-wheel-progressive-speed t)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
 '(path-to-ctags "~/Developer/bin/ctags")
 '(preview-transparent-color "black")
 '(quack-programs (quote ("mzscheme" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-remap-find-file-bindings-p nil)
 '(rails-indent-and-complete nil)
 '(rails-minor-mode-prefix-key " ;")
 '(ruby-electric-expand-delimiters-list (quote (123 91 40 39 34 96)))
 '(rvm-default-ruby-name "ruby-1.9.2-p290")
 '(rvm-executable "~/Developer/.rvm/bin/rvm")
 '(rvm-ruby-187-name "ruby-1.8.7-p302")
 '(safe-local-variable-values (quote ((C++\;indent-tabs-mode . t) (textmate-gf-exclude . "(/|^)(\\.+[^/]+|vendor|tmp|log|classes|build)($|/)|(\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc)(/|$)") (textmate-gf-exclude . "(/|^)(\\.+[^/]+|vendor|fixtures|tmp|log|build)($|/)|(\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc)(/|$)") (textmate-gf-exclude . "(/|^)(.+[^/]+|vendor|fixtures|tmp|log|build)($|/)|(.xcodeproj|.nib|.framework|.app|.pbproj|.pbxproj|.xcode|.xcodeproj|.bundle|.pyc)(/|$)") (textmate-gf-exclude "(/|^)(.+[^/]+|vendor|fixtures|tmp|log|build)($|/)|(.xcodeproj|.nib|.framework|.app|.pbproj|.pbxproj|.xcode|.xcodeproj|.bundle|.pyc)(/|$)") (textmate-project-roots "(/|^)(.+[^/]+|vendor|fixtures|tmp|log|build)($|/)|(.xcodeproj|.nib|.framework|.app|.pbproj|.pbxproj|.xcode|.xcodeproj|.bundle|.pyc)(/|$)") (encoding . utf-8) (textmate-project-roots ".dir-locals.el") (ack-arguments "--ignore-dir=ruby") (*textmate-gf-exclude* . "/\\.|vendor|ruby/gems|classes|fixtures|tmp|log|build|\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc") (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(sentence-end-double-space nil)
 '(sh-basic-offset 2)
 '(sh-indentation 2)
 '(sh-shell-file "/bin/bash")
 '(shell-file-name "/bin/bash")
 '(show-paren-mode t)
 '(tab-width 2)
 '(tex-dvi-view-command (quote open))
 '(textile-browser-command (quote ("open" "-a" "Safari")))
 '(tls-program (quote ("openssl s_client -connect %h:%p -no_ssl2 -ign_eof")))
 '(tool-bar-mode nil)
 '(toolbar-mail-reader (quote gnus))
 '(toolbar-news-reader (quote gnus))
 '(transient-mark-mode (quote (only . t)))
 '(truncate-lines t)
 '(whitespace-style (quote (trailing tabs newline tab-mark newline-mark)) t)
 '(yas/trigger-key "TAB"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "White"))))
 '(hl-line ((t (:inherit highlight :background "#302500")))))

(setenv "PATH" (format "%s/bin:%s/Developer/bin:%s"
                       (getenv "HOME")
                       (getenv "HOME")
                       (getenv "PATH")))
