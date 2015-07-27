;;this makes emacs use the melpa package archive, which has alot more stuff than the default one
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

(defun line-jump-then-to-indent()
  "run ace-jump-line-mode and then back-to-indentation"
  (interactive)
  (ace-jump-line-mode)
  (back-to-indentation))

;;set ace jump char key chords
;;replaced next with C-;
;;(key-chord-define-global "fj" 'ace-jump-char-mode)
(key-chord-define-global "dk" 'line-jump-then-to-indent)
(global-set-key (kbd "C-;") 'ace-jump-char-mode)
(global-set-key (kbd "M-g w") 'ace-jump-word-mode)
(global-set-key (kbd "M-g l") 'ace-jump-line-mode)

;;multiple cursors
(require 'multiple-cursors)
(key-chord-define-global "vn" 'mc/edit-lines)
(key-chord-define-global "cm" 'mc/mark-all-like-this)

;;evaluation bindings
(key-chord-define-global "aj" 'eval-print-last-sexp)

;;turn on key chord mode and config
(set-variable 'key-chord-two-keys-delay 0.01) ;;only work when keys pressed at the same time
(key-chord-mode +1)

;;waste of screen space
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;easy backspace
;;(define-key key-translation-map (kbd "C-'") (kbd "DEL"))

;;eazy repeat
(global-set-key (kbd "C-z") 'repeat)

;;auto paredit
(add-hook 'cider-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
;;start maximised
(toggle-frame-maximized)

;;remove welcome screen
(setq inhibit-startup-message t)

;;shortcut for editing init file
(defun open-init-file ()
  "opens init.el in a buffer"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "M-1") 'open-init-file)

;;auto close brackets
(autopair-global-mode 1)
(setq autopair-autowrap t)

;;things for c++ development
;;enable helm
(require 'helm-config)
(helm-mode 1)
;;helm + helm-gtags configuration
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;;helm ;;note to self: think about enabling helm fuzzy matching
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;moo-complete from package function-args
;;(global-set-key (kbd "C-i") 'moo-complete) ;;mabye not necessary because of C-M-i

;;company mode gives automatc completion
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


;;semantic mode
(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

;;this is how you would add more include paths to semantic:
;; (semantic-add-system-include "/usr/include/boost" 'c++-mode)

;;function-args mode keybinding
(require 'function-args)
(fa-config-default)
(define-key c-mode-map  [(control tab)] 'moo-complete)
(define-key c++-mode-map  [(control tab)] 'moo-complete)
(define-key c-mode-map (kbd "M-o")  'fa-show)
(define-key c++-mode-map (kbd "M-o")  'fa-show)

;;make ede always on
(require 'ede)
(global-ede-mode)

;;show paren mode
(show-paren-mode)

;;projectile ;no longer installed, keep in case I want it again
;(setq projectile-enable-caching t) ;;this lets projectile cache files it found in the project
;;helm projectile
;(projectile-global-mode)
;(setq projectile-completion-system 'helm)
;(helm-projectile-on)

;;rainbow delimeters mode
(rainbow-delimiters-mode)

;;javascript mode-line
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

;;enable all disabled commands
(setq disabled-command-function nil)
