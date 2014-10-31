(defvar gaff-daily-tips
  '(;"Press <C-c o> to open a file with external program."
    ;"Press <C-c p f> to navigate a project's files with ido."
    ;"Press <C-c p s g> to run grep on a project."
    ;"Press <C-c p p> to switch between projects."
    ;"Press <C-=> to expand the selected region."
    ;"Press <C-c g> to search in Google."
    ;"Press <C-c G> to search in GitHub."
    ;"Press <C-c y> to search in YouTube."
    ;"Press <C-c U> to search in DuckDuckGo."
    ;"Press <C-c r> to rename the current buffer and the file it's visiting if any."
    ;"Press <C-c t> to open a terminal in Emacs."
    ;"Press <C-c k> to kill all the buffers, but the active one."
    ;"Press <C-x g> to run magit-status."
    ;"Press <C-c D> to delete the current file and buffer."
    ;"Press <C-c s> to swap two windows."
    ;"Press <S-RET> or <M-o> to open a line beneath the current one."
    ;"Press <s-o> to open a line above the current one."
    ;"Press <C-c C-z> in a Elisp buffer to launch an interactive Elisp shell."
    ;"Press <C-Backspace> to kill a line backwards."
    ;"Press <C-S-Backspace> or <s-k> to kill the whole line."
    ;"Press <f11> to toggle fullscreen mode."
    ;"Press <f12> to toggle the menu bar."
    "Access the official Emacs manual by pressing <C-h r>."
    "Visit the EmacsWiki at http://emacswiki.org to find out even more about Emacs."))

(defun gaff-tip-of-the-day ()
  "Display a random entry from `gaff-daily-tips'."
  (interactive)
  (unless (window-minibuffer-p)
    ;; pick a new random seed
    (random t)
    (message
     (concat "Gaff tip: " (nth (random (length gaff-daily-tips)) gaff-daily-tips)))))

(defun gaff-eval-after-init (form)
    "Add `(lambda () FORM)' to `after-init-hook'.
    If Emacs has already finished initialization, also eval FORM immediately."
    (let ((func (list 'lambda nil form)))
      (add-hook 'after-init-hook func)
      (when after-init-time
	(eval form))))

(provide 'gaff-core)
