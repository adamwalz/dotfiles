(gaff-require-packages '(guru-mode))

(defun gaff-local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t))

(defun gaff-font-lock-comment-annotations ()
    "Highlight a bunch of well known comment annotations.
This functions should be added to the hooks of major modes for programming."
    (font-lock-add-keywords
     nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
            1 font-lock-warning-face t))))
;; show the name of the current function definition in the modeline
(require 'which-func)
(which-function-mode 1)

;; smart curly braces
(sp-pair "{" nil :post-handlers
         '(((lambda (&rest _ignored)
              (gaff-smart-open-line-above)) "RET")))

;; enlist a more liberal guru
(setq guru-warn-only t)

(defun gaff-prog-mode-defaults ()
  "Default coding hook, useful with any programming language."
  (when (and (executable-find ispell-program-name)
             gaff-flyspell)
    (flyspell-prog-mode))
  (when gaff-guru
    (guru-mode +1))
  (smartparens-mode +1)
  (gaff-enable-whitespace)
  (gaff-local-comment-auto-fill)
  (gaff-font-lock-comment-annotations))

(setq gaff-prog-mode-hook 'gaff-prog-mode-defaults)

(add-hook 'prog-mode-hook (lambda ()
                            (run-hooks 'gaff-prog-mode-hook)))

;; enable on-the-fly syntax checking
(if (fboundp 'global-flycheck-mode)
    (global-flycheck-mode +1)
    (add-hook 'prog-mode-hook 'flycheck-mode))

(provide 'gaff-programming)
