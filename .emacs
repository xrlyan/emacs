;; line no
(global-linum-mode 1)

;; Hide splash-screen and startup-message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; full screen
(defun switch-full-screen ()
      (interactive)
      (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))
(global-set-key [f11] 'switch-full-screen)
;; start up with full-screen
(switch-full-screen)

(global-set-key [f1] 'shell)

;;cancel the *~ back file
(setq make-backup-files nil)


(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
(setq yas/trigger-key (kbd "M-["))

(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-1.3.1")
(require 'auto-complete) 
(require 'auto-complete-config) 
(global-auto-complete-mode t) 
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers)) 
(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols))) 
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename))) 
(set-face-background 'ac-candidate-face "lightgray") 
(set-face-underline 'ac-candidate-face "darkgray") 
(set-face-background 'ac-selection-face "steelblue") 

(define-key ac-completing-map "\M-n" 'ac-next) 

(define-key ac-completing-map "\M-p" 'ac-previous) 
(setq ac-auto-start 2) 
(setq ac-dwim t) 
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)


;; python-mode settings
(add-to-list 'load-path "~/.emacs.d/plugins")
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist(cons '("python" . python-mode)
                               interpreter-mode-alist))
;; path to the python interpreter, e.g.: ~rw/python27/bin/python2.7
(setq py-python-command "python")
(autoload 'python-mode "python-mode" "Python editing mode." t)
;; ;; pymacs settings
(setq pymacs-python-command py-python-command)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")

;;(require 'pycomplete)


;;set ipython as the shell
(setq ipython-command "/bin/ipython")
(require 'ipython)

(require 'python-pylint)
;;(load-library "pylint")
;; use flymake with pylint
(when (load "flymake" t)
  (defun flymake-pylint-init ()
        (let* ((temp-file (flymake-init-create-temp-buffer-copy
                                                   'flymake-create-temp-inplace))
                          (local-file (file-relative-name
                                                                temp-file
                                                                                        (file-name-directory buffer-file-name))))
                (list "epylint" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
                              '("\\.py\\'" flymake-pylint-init)))



;;;;;;;;;;;;;;;;;
;auctex
;;;;;;;;;;;;;;;;;
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(mapc (lambda (mode)
(add-hook 'LaTeX-mode-hook mode))
      (list 'auto-complete-mode
   'auto-fill-mode
   'LaTeX-math-mode
   'turn-on-reftex
   'linum-mode))
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-engine 'xetex       ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))
; set pdf view tool
(setq TeX-view-program-list '(("Evince" "evince %o")))
(cond
 ((eq system-type 'windows-nt)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq TeX-view-program-selection '((output-pdf "SumatraPDF")
                                                 (output-dvi "Yap"))))))

 ((eq system-type 'gnu/linux)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq TeX-view-program-selection '((output-pdf "Evince")
                                                 (output-dvi "Evince")))))))
; XeLaTeX
(add-hook 'LaTeX-mode-hook (lambda()
    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
    (setq TeX-command-default "XeLaTeX")
    (setq TeX-save-query  nil )
    (setq TeX-show-compilation t)
    ))
(put 'upcase-region 'disabled nil)
