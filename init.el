;; load site-lisp directory
(setq site-lisp-directory "~/.emacs.d/site-lisp")

; set load-path to top-level site-lisp directory
(setq load-path `(site-listp-directory
								  ,@load-path))

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;;(load-file (concat site-lisp-directory "/cedet-1.0pre6/common/cedet.el"))

;; Enable EDE (Project Management) features
;;(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

;; Emacs Code Browser support
;;(add-to-list 'load-path (concat site-lisp-directory "/ecb-snap"))
;;(require 'ecb-autoloads)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(ns-antialias-text t)
 '(ns-pop-up-frames nil)
 '(remote-shell-program "/usr/bin/ssh")
 '(require-final-newline t)
 '(tab-always-indent nil)
 '(tab-width 4))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; php-mode
(add-to-list 'load-path (concat site-lisp-directory "/php-mode"))
(require 'php-mode)
;; using abbrev-mode
(add-hook 'php-mode-hook
		  '(lamdba () (define-abbrev php-mode-abbrev-table "ex" "extends")))

;; python-mode
(add-to-list 'load-path (concat site-lisp-directory "/python-mode"))
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; ruby-mode
(add-to-list 'load-path (concat site-lisp-directory "/ruby-mode-cvs"))
(require 'ruby-mode)
(require 'ruby-electric)
;; auto-load
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
	  (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
									 interpreter-mode-alist))

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
		  '(lambda ()
			 (inf-ruby-keys)
			 ))

(add-to-list 'load-path (concat site-lisp-directory "/yasnippet"))
(require 'yasnippet-bundle)

(setq-default help-at-pt-display-when-idle t)

;; set mode to always use spaces
(setq-default indent-tabs-mode nil)

;; which function mode (show which function you're in)
(setq-default which-function-mode t)

;; electric mode
(setq-default c-toggle-electric-state t)

;; flymake-php extension
(add-to-list 'load-path (concat site-lisp-directory "/flymake-php"))
(require 'flymake-php)
(add-hook 'php-mode-user-hook 'flymake-php-load)

;; flymake-ruby extension
(add-to-list 'load-path (concat site-lisp-directory "/flymake-ruby"))
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; make flymake commands to frequently used ones
(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
(global-set-key [f4] 'flymake-goto-next-error)

(defun flymake-html-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
					 'flymake-create-temp-inplace))
		 (local-file (file-relative-name
					  temp-file
					  (file-name-directory buffer-file-name))))
	(list "tidy" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.html$\\|\\.ctp" flymake-html-init))

(add-to-list 'flymake-err-line-patterns
			 '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
			   nil 1 2 4)) (defun flymake-html-init ()
			 (let* ((temp-file (flymake-init-create-temp-buffer-copy
								'flymake-create-temp-inplace))
					(local-file (file-relative-name
								 temp-file
								 (file-name-directory buffer-file-name))))
			   (list "tidy" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.html$\\|\\.ctp" flymake-html-init))
(add-to-list 'flymake-err-line-patterns
			 '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
			   nil 1 2 4))

;; move backup directory
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
	  `(("." . ,user-temporary-file-directory)
		(,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
	  (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
	  `((".*" ,user-temporary-file-directory t)))

(require 'filecache)

;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)

; Show column of line number on the left
(load-file (concat site-lisp-directory "/linum.el"))
(require 'linum)
(global-linum-mode)

; Highlight parentheses
(load-file (concat site-lisp-directory "/highlight-parentheses.el"))
(require 'highlight-parentheses)
(show-paren-mode)

;; enable visual feedback on selections
(setq transient-mark-mode t)

(setq
 sgml-set-face t
 sgml-markup-faces
		  '((start-tag . font-lock-keyword-face)
			(end-tag . font-lock-keyword-face)
			(ignored . font-lock-string-face)
			(ms-start . font-lock-other-type-face)
			(ms-end . font-lock-other-type-face)
			(shortref . bold)
			(entity . font-lock-reference-face)
			(comment . font-lock-comment-face)
			(pi . other-emphasized-face)
			(sgml . font-lock-function-name-face)
			(doctype . font-lock-emphasized-face))
			)

(setq sgml-auto-activate-dtd t)

;; paredit (for S-expressions)
(load-file (concat site-lisp-directory "/paredit.el"))
(mapc (lambda (mode)
	(let ((hook (intern (concat (symbol-name mode)
					"-mode-hook"))))
	  (add-hook hook (lambda () (paredit-mode +1)))))
	  '(emacs-lisp lisp inferior-lisp))

;; p4 editing capabilities
;; (when (executable-find "p4")
;; 	(add-to-list 'load-path (concat site-lisp-directory "/p4"))
;; 	(load-library "p4"))

(defun open-line-above ()
  "Open a line above the line the point is at.
Then move to that line and indent accordning to mode"
  (interactive)
  (move-beginning-of-line 1)
  (newline)
  (previous-line)
  (indent-according-to-mode))

(defun open-line-below ()
  "Open a line below the line the point is at.
Then move to that line and indent accordning to mode"
  (interactive)
  (move-end-of-line 1)
  (newline)
  (indent-according-to-mode))

(global-set-key (kbd "C-o") 'open-line-above)
(global-set-key (kbd "C-O") 'open-line-below)


; Replace yes-or-no question responses with y-or-n responses
(fset 'yes-or-no-p 'y-or-n-p)

; Ensure newline at end of all files
(setq require-final-newline t)

;;clojure-mode
(add-to-list 'load-path (concat site-lisp-directory "/clojure-mode"))
(require 'clojure-mode)

;; swank-clojure
(add-to-list 'load-path (concat site-lisp-directory "/swank-clojure"))

(require 'swank-clojure-autoload)
(swank-clojure-config
 (setq swank-clojure-jar-path "~/.clojure/clojure-1.0.0.jar")
 (setq swank-clojure-extra-classpaths
       (list "~/.clojure/clojure-contrib.jar")))

;; load slime ONLY when clisp is present on the system
(when (executable-find "clisp")
  (add-to-list 'load-path (concat site-lisp-directory "/slime"))  ; your SLIME directory
  (setq inferior-lisp-program (executable-find "clisp")) ; your Lisp system
  (require 'slime)
  (slime-setup)

  (add-hook 'slime-mode-hook
			(lambda ()
			  (unless (slime-connected-p)
				(save-excursion (slime))))))

;; try loading p4 from Apollo environment
(when (executable-find "p4")
  (add-to-list 'load-path (concat site-lisp-directory "/apollo/env/Emacs22"))
  (load-library "p4"))

;; auto load html-mode for JSPs
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tag\\'" . html-mode))
;; Not exactly related to editing HTML: enable editing help with mouse-3 in all sgml files
(defun go-bind-markup-menu-to-mouse3 ()
  (define-key sgml-mode-map [(down-mouse-3)] 'sgml-tags-menu))

;; load server-mode at start
(server-start)

;; use f5 to refresh buffer
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t))

(global-set-key [f5]
'(lambda () "Refresh the buffer from the disk (prompt of modified)."
(interactive)
(revert-buffer t (not (buffer-modified-p)) t)))

;; css-mode
(add-to-list 'load-path (concat site-lisp-directory "/css-mode"))
(require 'css-mode)
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)

;You may also want something like:

(setq auto-mode-alist
      (append '(("\\.css$" . css-mode))
              auto-mode-alist))

;; wikipedia-mode
(add-to-list 'load-path (concat site-lisp-directory "/wikipedia-mode"))
(autoload 'wikipedia-mode "wikipedia-mode.el"
"Major mode for editing wikipedia documents. " t)

;; longlines-mode
(add-to-list 'load-path (concat site-lisp-directory "/longlines-mode"))
(autoload 'longlines-mode
  "longlines.el"
  "Minor mode for automatically wrapping long lines" t)

;; smart-indent mode
(defvar smart-tab-using-hippie-expand t
  "turn this on if you want to use hippie-expand completion.")

(defun smart-tab (prefix)
  "Needs `transient-mark-mode' to be on. This smart tab is
  minibuffer compliant: it acts as usual in the minibuffer.

  In all other buffers: if PREFIX is \\[universal-argument], calls
  `smart-indent'. Else if point is at the end of a symbol,
  expands it. Else calls `smart-indent'."
  (interactive "P")
  (labels ((smart-tab-must-expand (&optional prefix)
                                  (unless (or (consp prefix)
                                              mark-active)
                                    (looking-at "\\_>"))))
    (cond ((minibufferp)
           (minibuffer-complete))
          ((smart-tab-must-expand prefix)
           (if smart-tab-using-hippie-expand
               (hippie-expand nil)
             (dabbrev-expand nil)))
          ((smart-indent)))))

(defun smart-indent ()
  "Indents region if mark is active, or current line otherwise."
  (interactive)
  (if mark-active
    (indent-region (region-beginning)
                   (region-end))
    (indent-for-tab-command)))
(define-key read-expression-map [(tab)] 'hippie-expand)
(define-key read-expression-map [(shift tab)] 'unexpand)

;;; groovy-mode
(add-to-list 'load-path (concat site-lisp-directory "/groovy-mode"))
;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;; javascript-mode
(add-to-list 'load-path site-lisp-directory)
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

