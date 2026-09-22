;; color-set.lsp - Set the color of selected objects by number
;; Command: CSET
(defun c:CSET ( / ss c )
  (setq ss (ssget))
  (if ss
    (progn
      (setq c (getint "\nACI color number (1-255): "))
      (if (and c (>= c 1) (<= c 255))
        (progn
          (command "_.CHPROP" ss "" "_C" c "")
          (princ (strcat "\nColor set to " (itoa c) "."))
        )
      )
    )
  )
  (princ)
)
