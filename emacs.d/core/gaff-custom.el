;; customize
(defgroup gaff nil
  "Emacs Gaff configuration."
  :prefix "gaff-"
  :group 'convenience)

(defcustom gaff-auto-save t
  "Non-nil values enable Gaff's auto save."
  :type 'boolean
  :group 'gaff)

(defcustom gaff-theme 'wombat
  "The default color theme, change this in your /personal/preload config."
  :type 'symbol
  :group 'gaff)

(provide 'gaff-custom)
