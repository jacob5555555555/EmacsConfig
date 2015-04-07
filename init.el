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

;;start maximised
(toggle-frame-maximized)

;;remove welcome screen
(setq inhibit-startup-message t)
