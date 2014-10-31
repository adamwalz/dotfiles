;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(menu-bar-mode -1)

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; nice scrolling
(setq scroll-margin 0
  scroll-conservatively 100000
  scroll-preserve-screen-position 1)

;; make the fringe (gutter) smaller
;; the argument is a width in pixel (the default is 8)
(if (fboundp 'fringe-mode)
  (fringe-mode 4))

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; more useful frame title, the shows either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
  '("" invocation-name "Emacs - " (:eval (if (buffer-file-name)
				     (abbreviate-file-name (buffer-file-name))
				   "%b"))))

;; load the default color theme
(load-theme gaff-theme t)

(provide 'gaff-ui)
