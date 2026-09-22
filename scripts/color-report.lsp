;; color-report.lsp - Count objects by color
;; Command: COLREPORT
(defun c:COLREPORT ( / ss i en ed col item alist )
  (setq ss (ssget "_X"))
  (if ss
    (progn
      (setq i 0 alist nil)
      (repeat (sslength ss)
        (setq en (ssname ss i)
              ed (entget en)
              col (cdr (assoc 62 ed)))
        (if (null col) (setq col 256))
        (setq item (assoc col alist))
        (if item
          (setq alist (subst (cons col (1+ (cdr item))) item alist))
          (setq alist (cons (cons col 1) alist))
        )
        (setq i (1+ i))
      )
      (foreach item alist
        (princ (strcat "\nColor " (itoa (car item))
                       (if (= (car item) 256) " (ByLayer)" "")
                       ": " (itoa (cdr item)) " objects"))
      )
    )
  )
  (princ)
)
