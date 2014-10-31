;; customize
(defgroup gaff nil
  "Emacs Gaff configuration."
  :prefix "gaff-"
  :group 'convenience)

(defcustom gaff-auto-save t
  "Non-nil values enable Gaff's auto save."
  :type 'boolean
  :group 'gaff)

(defcustom gaff-guru t
  "Non-nil values enable `guru-mode'."
  :type 'boolean
  :group 'gaff)

(defcustom gaff-whitespace t
  "Non-nil values enable gaff's whitespace visualization."
  :type 'boolean
  :group 'gaff)

(defcustom gaff-clean-whitespace-on-save t
    "Cleanup whitespace from file before it's saved.
Will only occur if `gaff-whitespace' is also enabled."
    :type 'boolean
    :group 'gaff)

(defcustom gaff-flyspell t
  "Non-nil values enable Gaff's flyspell support."
  :type 'boolean
  :group 'gaff)

(defcustom gaff-theme 'wombat
  "The default color theme, change this in your /personal/preload config."
  :type 'symbol
  :group 'gaff)

(provide 'gaff-custom)
