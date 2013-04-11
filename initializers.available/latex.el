;; You must first install auctex!  This thread has good instructions on doing so on OSx:
;; http://superuser.com/questions/171681/installing-auctex-1-86-over-emacs-app-in-os-x
;; Homebrew also has a formula that looks good (I didn't notice it at the time)
;; For preview to work you need a patched version of 8.71 since the current preview.el doesn't work with 9.x
;; wget http://downloads.ghostscript.com/public/ghostscript-8.71.tar.gz
;; extract ghostscript-8.71.tar.gz
;; cd ghostscript-8.71
;; Apply patch:
;; --- a/base/unix-dll.mak
;; +++ b/base/unix-dll.mak
;; @@ -52,13 +52,13 @@

;;  # MacOS X
;; -#GS_SOEXT=dylib
;; -#GS_SONAME=$(GS_SONAME_BASE).$(GS_SOEXT)
;; -#GS_SONAME_MAJOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
;; -#GS_SONAME_MAJOR_MINOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
;; -#LDFLAGS_SO=-dynamiclib -flat_namespace
;; -#LDFLAGS_SO=-dynamiclib -install_name $(GS_SONAME_MAJOR_MINOR)
;; -#LDFLAGS_SO=-dynamiclib -install_name $(FRAMEWORK_NAME)
;; +GS_SOEXT=dylib
;; +GS_SONAME=$(GS_SONAME_BASE).$(GS_SOEXT)
;; +GS_SONAME_MAJOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
;; +GS_SONAME_MAJOR_MINOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
;; +LDFLAGS_SO=-dynamiclib -flat_namespace
;; +LDFLAGS_SO=-dynamiclib -install_name $(GS_SONAME_MAJOR_MINOR)
;; +LDFLAGS_SO=-dynamiclib -install_name $(FRAMEWORK_NAME)
;;
;;  GS_SO=$(BINDIR)/$(GS_SONAME)
;;  GS_SO_MAJOR=$(BINDIR)/$(GS_SONAME_MAJOR)

;; Apply patch: https://bugzilla.redhat.com/attachment.cgi?id=395186&action=diff#ghostscript-8.71/lib/pdf2dsc.ps.copy_trailer_attrs_sec1

;; ./configure --prefix=/usr/local --disable-cups --disable-compile-inits --disable-gtk --with-system-libtiff --without-x
;; make && make install && make install-so

;; (add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))

(load "auctex.el" nil t t)
(load "preview.el" nil t t)
;; use pdf instead of DVI
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
;; (setq TeX-PDF-mode t)

;; setup org-babel to use latex
(require 'ob-latex)
;; Add LaTeX to a list of languages that raise noweb-type errors.
(add-to-list 'org-babel-noweb-error-langs "latex")

(setq pdflatex "/usr/texbin/pdflatex")

(defun tex-build-and-preview (&optional file)
  (interactive)
  (save-buffer)
  (shell-command (format "mkdir -p /tmp/pdflatex; %s -output-directory=/tmp/pdflatex %s && open /tmp/pdflatex/%s" pdflatex buffer-file-name (concat (file-name-sans-extension (file-name-nondirectory buffer-file-name)) ".pdf")))
  )

;; (add-hook 'LaTeX-mode-hook
;;           (lambda ()
;;             (define-key latex-mode-map (kbd "C-c x") 'tex-build-and-preview))
;;           )

(require 'tex-buf)
(defun TeX-command-default (name)
  "Next TeX command to use. Most of the code is stolen from `TeX-command-query'."
  (cond ((if (string-equal name TeX-region)
             (TeX-check-files (concat name "." (TeX-output-extension))
                              (list name)
                              TeX-file-extensions)
           (TeX-save-document (TeX-master-file)))
         TeX-command-default)
        ((and (memq major-mode '(doctex-mode latex-mode))
              (TeX-check-files (concat name ".bbl")
                               (mapcar 'car
                                       (LaTeX-bibliography-list))
                               BibTeX-file-extensions))
         ;; We should check for bst files here as well.
         TeX-command-BibTeX)
        ((TeX-process-get-variable name
                                   'TeX-command-next
                                   TeX-command-Show))
        (TeX-command-Show)))

;;;  from wiki
(defcustom TeX-texify-Show t
  "Start view-command at end of TeX-texify?"
  :type 'boolean
  :group 'TeX-command)

(defcustom TeX-texify-max-runs-same-command 5
  "Maximal run number of the same command"
  :type 'integer
  :group 'TeX-command)

(defun TeX-texify-sentinel (&optional proc sentinel)
  "Non-interactive! Call the standard-sentinel of the current LaTeX-process.
If there is still something left do do start the next latex-command."
  (set-buffer (process-buffer proc))
  (funcall TeX-texify-sentinel proc sentinel)
  (let ((case-fold-search nil))
    (when (string-match "\\(finished\\|exited\\)" sentinel)
      (set-buffer TeX-command-buffer)
      (unless (plist-get TeX-error-report-switches (intern (TeX-master-file)))
        (TeX-texify)))))

(defun TeX-texify ()
  "Get everything done."
  (interactive)
  (let ((nextCmd (TeX-command-default (TeX-master-file)))
        proc)
    (if (and (null TeX-texify-Show)
             (equal nextCmd TeX-command-Show))
        (when  (called-interactively-p 'any)
          (message "TeX-texify: Nothing to be done."))
      (TeX-command nextCmd 'TeX-master-file)
      (when (or (called-interactively-p 'any)
                (null (boundp 'TeX-texify-count-same-command))
                (null (boundp 'TeX-texify-last-command))
                (null (equal nextCmd TeX-texify-last-command)))
        (mapc 'make-local-variable '(TeX-texify-sentinel TeX-texify-count-same-command TeX-texify-last-command))
        (setq TeX-texify-count-same-command 1))
      (if (>= TeX-texify-count-same-command TeX-texify-max-runs-same-command)
          (message "TeX-texify: Did %S already %d times. Don't want to do it anymore." TeX-texify-last-command TeX-texify-count-same-command)
        (setq TeX-texify-count-same-command (1+ TeX-texify-count-same-command))
        (setq TeX-texify-last-command nextCmd)
        (and (null (equal nextCmd TeX-command-Show))
             (setq proc (get-buffer-process (current-buffer)))
             (setq TeX-texify-sentinel (process-sentinel proc))
             (set-process-sentinel proc 'TeX-texify-sentinel))))))

(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (define-key LaTeX-mode-map (kbd "C-c C-a") 'TeX-texify)))
