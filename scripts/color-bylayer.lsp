;; color-bylayer.lsp - Set selected objects back to ByLayer color
;; Command: CBYLAYER
;; Usage: the fastest way to fix objects whose color was overridden
(defun c:CBYLAYER ( / ss )
  (setq ss (ssget))
  (if ss
    (progn
      (command "_.CHPROP" ss "" "_C" "_BYLAYER" "")
      (princ (strcat "\n" (itoa (sslength ss)) " objects set to ByLayer color."))
    )
  )
  (princ)
)
