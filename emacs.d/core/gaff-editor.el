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

;; Compilation from Emacs
(defun gaff-colorize-compilation-buffer ()
  "Colorize a compilation mode buffer."
  (interactive)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

(provide 'gaff-editor)
