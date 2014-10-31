(require 'gaff-programming)
(gaff-require-packages '(js2-mode json-mode))

(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'"    . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(eval-after-load 'js2-mode
  '(progn
     (defun gaff-js-mode-defaults ()
       ;; electric-layout-mode doesn't play nice with smartparens
       (setq-local electric-layout-rules '((?\; . after)))
       (setq mode-name "JS2")
       (js2-imenu-extras-mode +1))

     (setq gaff-js-mode-hook 'gaff-js-mode-defaults)

     (add-hook 'js2-mode-hook (lambda () (run-hooks 'gaff-js-mode-hook)))))

(provide 'gaff-javascript)
