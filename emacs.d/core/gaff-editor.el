(setq-default indent-tabs-mode nil)   ;; seriously? tabs?
(setq-default tab-width 8)            ;; for visual compatibility

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
(delete-selection-mode t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; smart pairing for all
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)

;; disable blink-matching-paren
; (setq blink-matching-paren nil)

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defun gaff-auto-save-command ()
  "Save the current buffer if `auto-save' is not nil."
  (when (and gaff-auto-save
	     buffer-file-name
	     (buffer-modified-p (current-buffer))
	     (file-writable-p buffer-file-name))
    (save-buffer)))

(when (version<= "24.4" emacs-version)
  (add-hook 'focus-out-hook 'gaff-auto-save-command))

;; highlight the current line
;(global-hl-line-mode +1)

;; flyspell-mode does spell-checking on the fly as you type
(require 'flyspell)
(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))

(defun gaff-enable-flyspell ()
  "Enable command `flyspell-mode' if `gaff-flyspell' is not nil."
  (when (and gaff-flyspell (executable-find ispell-program-name))
    (flyspell-mode +1)))

(defun gaff-cleanup-maybe ()
  "Invoke `whitespace-cleanup' if `gaff-clean-whitespace-on-save' is not nil."
  (when gaff-clean-whitespace-on-save
    (whitespace-cleanup)))

(defun gaff-enable-whitespace ()
  "Enable `whitespace-mode' if `gaff-whitespace' is not nil."
  (when gaff-whitespace
    ;; keep the whitespace decent all the time (in this buffer)
    (add-hook 'before-save-hook 'gaff-cleanup-maybe nil t)
    (whitespace-mode +1)))

(add-hook 'text-mode-hook 'gaff-enable-flyspell)
(add-hook 'text-mode-hook 'gaff-enable-whitespace)

;; Compilation from Emacs
(defun gaff-colorize-compilation-buffer ()
  "Colorize a compilation mode buffer."
  (interactive)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

(provide 'gaff-editor)
