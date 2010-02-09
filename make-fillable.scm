(define (comic-fu-make-fillable img
                                line-layer
                                alpha-threshold)
  (begin
    (gimp-image-undo-group-start img)
    (let* (
           (color-layer (car (gimp-layer-copy line-layer 0)))
           (color-layer-position (+ 1 (car (gimp-image-get-layer-position img line-layer)))))
      (gimp-image-add-layer img color-layer color-layer-position)
      (gimp-drawable-set-name color-layer (string-append (car (gimp-drawable-get-name line-layer)) " colors"))
      (plug-in-threshold-alpha 1 img color-layer alpha-threshold))
    (gimp-image-undo-group-end img)
    (gimp-displays-flush)))

(script-fu-register "comic-fu-make-fillable"
                    _"Make _Fillable"                                     ;menu label
                    _"Duplicates the current layer and alpha thresholds the duplicate, so it can be easily bucket-filled."
                    "Paul Bonser <pib@paulbonser.com>"
                    "Paul Bonser"
                    "February 9, 2010"
                    "RGBA"
                    
                    SF-IMAGE       "Image"            0
                    SF-DRAWABLE    "Drawable"         0
                    SF-ADJUSTMENT  _"Alpha Threshold" '(220 1 255 1 10 0 0))

(script-fu-menu-register "comic-fu-make-fillable"
                         "<Image>/Filters/Comic-Fu")
