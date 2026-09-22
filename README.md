# GstarCAD Color Tools

Return objects to ByLayer color, set a color by ACI number and count objects by color across the drawing.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Objects with overridden colors are a classic source of mess in drawings. These utilities return a selection to ByLayer color, set a specific ACI color number quickly, and count every object by color so colour chaos is easy to find before plotting.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/color-bylayer.lsp` | ;; color-bylayer.lsp - Set selected objects back to ByLayer color
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
 |
| `scripts/color-set.lsp` | ;; color-set.lsp - Set the color of selected objects by number
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
 |
| `scripts/color-report.lsp` | ;; color-report.lsp - Count objects by color
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
