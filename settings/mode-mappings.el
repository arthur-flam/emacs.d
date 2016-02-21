

;; PYTHON SETUP
;; M-x jedi:install-server RET
;; have a notebook running
(add-hook 'python-mode-hook
          'jedi:setup)
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "'" 'skeleton-pair-insert-maybe)
            )
          )

(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)

(autoload 'ein "ein")
(setq jedi:complete-on-dot t)                 ; optional

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")
;; easy_install readline

;;(require 'flycheck-pyflakes)
;;(add-hook 'python-mode-hook 'flycheck-mode)
;;(add-to-list 'flycheck-disabled-checkers 'python-pylint)
;;(add-to-list 'flycheck-disabled-checkers 'python-flake8)

;; JAVA
;; https://github.com/senny/emacs-eclim
;;(autoload 'jdee-mode "jdee" "JDEE mode" t)
;;(setq auto-mode-alist
;;      (append '(("\\.java\\'" . jdee-mode)) auto-mode-alist))

(autoload 'web-mode "web-mode")
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(setq web-mode-engines-alist
      '(("liquid"    . "\\.html\\'")
        ("blade"  . "\\.blade\\."))
)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

(add-hook 'local-write-file-hooks
            (lambda ()
              (delete-trailing-whitespace)
              nil))

(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;;; Markdown
;;; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . markdown-mode))




(provide 'mode-mappings)
