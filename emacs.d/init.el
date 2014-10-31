(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Gaff is powering up emacs for you... Be patient, %s" current-user)

(when (version< emacs-version "24.1")
  (error "Gaff requires GNU Emacs 24.1 or higher, but you're running %s" emacs-version))

;; Always load newest byte code
(setq load-prefer-newer t)

(defvar gaff-dir (file-name-directory load-file-name)
  "The root dir of the Garr distribution.")
(defvar gaff-core-dir (expand-file-name "core" gaff-dir)
  "The home of Gaff's core functionality.")
(defvar gaff-personal-dir (expand-file-name "personal" gaff-dir)
    "This directory is for your personal configuration.

Users of Emacs Gaff are encouraged to keep their personal configuration
changes in this directory.  All Emacs Lisp files there are loaded automatically
by Gaff.")
(defvar gaff-personal-preload-dir (expand-file-name "preload" gaff-personal-dir)
  "This directory is for your personal configuration, that you want loaded before Gaff.")
(defvar gaff-modules-file (expand-file-name "gaff-modules.el" gaff-dir)
  "This files contains a list of modules that will be loaded by Gaff.")

;; add directories to Emacs's `load-path'
(add-to-list 'load-path gaff-core-dir)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; preload the personal settings from `gaff-personal-preload-dir'
(when (file-exists-p gaff-personal-preload-dir)
  (message "Loading personal configuration files in %s..." gaff-personal-preload-dir)
  (mapc 'load (directory-files gaff-personal-preload-dir 't "^[^#].*el$")))

(message "Loading Gaff core packages...")

;; The core stuff
(require 'gaff-packages)
(require 'gaff-custom)  ;; Needs to be loaded before core, editor and ui
(require 'gaff-ui)
(require 'gaff-core)
(require 'gaff-editor)

;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'gaff-osx))

;; config changes made through the customize UI will be store here
(setq custom-file (expand-file-name "custom.el" gaff-personal-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p gaff-personal-dir)
  (message "Loading personal configuration files in %s..." gaff-personal-dir)
  (mapc 'load (directory-files gaff-personal-dir 't "^[^#].*el$")))

(message "Emacs is ready, thanks for waiting %s" current-user)

(gaff-eval-after-init
 ;; greet the use with some useful tip
  (run-at-time 5 nil 'gaff-tip-of-the-day))
