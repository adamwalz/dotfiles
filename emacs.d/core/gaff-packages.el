(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; set package-user-dir to be relative to Gaff install path
(setq package-user-dir (expand-file-name "elpa" gaff-dir))
(package-initialize)

(defvar gaff-packages
  '(dash
    flycheck
    guru-mode
    smartparens)
  "A list of packages to ensure are installed at launch.")

(defun gaff-packages-installed-p ()
  "Check if all packages in `gaff-packages' are installed."
  (every #'package-installed-p gaff-packages))

(defun gaff-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package gaff-packages)
    (add-to-list 'gaff-packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun gaff-require-packages (packages)
    "Ensure PACKAGES are installed.
Missing packages are installed automatically."
    (mapc #'gaff-require-package packages))

(defun gaff-install-packages ()
  "Install all packages listed in `gaff-packages'."
  (unless (gaff-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Gaff is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (gaff-require-packages gaff-packages)))

;; run package installation
(gaff-install-packages)

(defmacro gaff-auto-install (extension package mode)
    "When file with EXTENSION is opened triggers auto-install of PACKAGE.
PACKAGE is installed only if not already present.  The file is opened in MODE."
    `(add-to-list 'auto-mode-alist
                  `(,extension . (lambda ()
                                   (unless (package-installed-p ',package)
                                     (package-install ',package))
                                   (,mode)))))

(defvar gaff-auto-install-alist
    '(("\\.coffee\\'" coffee-mode coffee-mode)
      ("\\.css\\'" css-mode css-mode)
      ("\\.latex\\'" auctex LaTeX-mode)
      ("\\.markdown\\'" markdown-mode markdown-mode)
      ("\\.md\\'" markdown-mode markdown-mode)
      ("\\.sass\\'" sass-mode sass-mode)
      ("\\.scala\\'" scala-mode2 scala-mode)
      ("\\.scss\\'" scss-mode scss-mode)))

;; markdown-mode doesn't have autoloads for the auto-mode-alist
;; so we add them manually if it's already installed
(when (package-installed-p 'markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;; build auto-install mappings
(mapc
 (lambda (entry)
   (let ((extension (car entry))
         (package (cadr entry))
         (mode (cadr (cdr entry))))
     (unless (package-installed-p package)
       (gaff-auto-install extension package mode))))
 gaff-auto-install-alist)

(provide 'gaff-packages)
