;; emacs -Q -l settings/profile-dotemacs.el -f profile-dotemacs
;; https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/
 
;; ==============================================================================
;; Adapted from https://github.com/magnars/.emacs.d/blob/master/init.el
;; ==============================================================================
;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


;; No splash screen please ... jeez
(setq inhibit-startup-message t)
(setq initial-major-mode 'org-mode)

;; Set path to dependencies
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(require 'appearance) ;; 0.1s

;;(require 'dired-x)
;;(add-hook 'dired-load-hook
;;        (function (lambda () (load "dired-x"))))


(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)
(normal-erase-is-backspace-mode 0)
(menu-bar-mode -1)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; Setup packages
(require 'setup-package)

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(
     magit
     exec-path-from-shell
     move-text
     visual-regexp
     markdown-mode
     ;;pos-tip
     ;;popup
     flycheck
     flycheck-pos-tip
     flx
     flx-ido
     dired-details
     css-eldoc
     jedi
     jdee
     smart-mode-line
     ;; solarized-theme
     smartparens
     ido-vertical-mode
     ido-at-point
     guide-key
     nodejs-repl
     highlight-escape-sequences
     whitespace-cleanup-mode
     elisp-slime-nav
     string-edit
     color-theme
     ein
     )
   ))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


;;(add-hook 'shell-mode-hook 
;;          'ansi-color-for-comint-mode-on)

;; Setup environment variables from the user's shell.
;;(when is-mac
;;  (require 'exec-path-from-shell)
;;  (exec-path-from-shell-initialize))

;; guide-key
(require 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-c" "C-c C-c" "C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
(setq guide-key/guide-key-sequence '("C-c" "C-x"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)
(setq guide-key/idle-delay 0.1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)

;; Setup extensions
(if (require 'smart-mode-line nil 'noerror)
    (progn
      (setq sml/name-width 20)
      (setq sml/mode-width 'full)
      (setq sml/shorten-directory t)
      (setq sml/shorten-modes t)

      (rich-minority-mode 1)
      (setq rm-blacklist '(" GitGutter" " MRev" " company" " mate" " Projectile"))

      (if after-init-time
        (sml/setup)
        (add-hook 'after-init-hook 'sml/setup))

      ;;(require-package 'smart-mode-line-powerline-theme)
      ;; (sml/apply-theme 'powerline)
      ;; Alternatives:
      ;; (sml/apply-theme 'powerline)
      ;; (sml/apply-theme 'dark)
      ;; (sml/apply-theme 'light)
      (sml/apply-theme 'respectful)
      ;; (sml/apply-theme 'automatic)
      (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/" ":DB:"))
      (add-to-list 'sml/replacer-regexp-list '("^~/Code/" ":CODE:"))
      (add-to-list 'sml/replacer-regexp-list '("^:CODE:investor-bridge" ":IB:"))
      (add-to-list 'sml/replacer-regexp-list '("^~/.*/lib/ruby/gems" ":GEMS" ))))

;; ;;(setq sml/theme 'solarized-dark)

(eval-after-load 'ido '(require 'setup-ido))
(eval-after-load 'org '(require 'setup-org))
(eval-after-load 'dired '(require 'setup-dired))
(eval-after-load 'magit '(require 'setup-magit))
;;(eval-after-load 'grep '(require 'setup-rgrep))
(eval-after-load 'shell '(require 'setup-shell))
(require 'setup-hippie)
;;(require 'setup-yasnippet)


;; Font lock dash.el
(eval-after-load "dash" '(dash-enable-font-lock))

;; Default setup of smartparens
(require 'smartparens-config)
(setq sp-autoescape-string-quote nil)

;; Load stuff on demand
(autoload 'auto-complete-mode "auto-complete" nil t)
(eval-after-load 'flycheck '(require 'setup-flycheck))

;; Map files to modes
(require 'mode-mappings)
(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; Highlight escape sequences
(require 'highlight-escape-sequences)
(hes-mode)
(put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)

;; Visual regexp
(require 'visual-regexp)
(define-key global-map (kbd "M-&") 'vr/query-replace)
(define-key global-map (kbd "M-/") 'vr/replace)

(require 'delsel)

;; Browse kill ring
(require 'browse-kill-ring)
(setq browse-kill-ring-quit-action 'save-and-restore)

;; Smart M-x is smart
;;(autoload 'smex "smex"
;;  "Smex is a M-x enhancement for Emacs, it provides a convenient interface to
;; your recently and most frequently used commands.")
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; Setup key bindings
(require 'key-bindings)

;; Misc
(require 'my-misc)
(when is-mac (require 'mac))

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))

(setq user-full-name "Arthur Flam"
      user-mail-address "arthur@fl.am")


;; BACKUP
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; History
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
