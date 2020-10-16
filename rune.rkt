#lang at-exp racket
(provide rune
         rune-rune
         rune-editor)

;TODO: I was lazy and didn't actually implement the compile function
;  left "as an exercise to the reader" -- hint: use (call-method ...)

(require "./util.rkt")

(define (rune)
  (test-modal-editor-rune-widget
   (list (rune-rune) (rune-editor))))

(define (rune-rune)
    (enclose
     (div
      (div id: (id "empty")
           (svg-rune-description
            (rune-background
             #:color "red"
             (rune-image
              (above
               (beside
                (square 20 'solid 'black)
                (square 20 'solid 'black))
               (beside
                (square 20 'solid 'black)
                (square 20 'solid 'black)))))))
      (div id: (id "full")
           style: (properties display:"none")
           (svg-rune-description
            (rune-background
             #:color "red"
             (rune-image
              (above
               (beside
                (square 20 'solid 'purple)
                (square 20 'solid 'black))
               (beside
                (square 20 'solid 'black)
                (square 20 'solid 'pink))))))))
     (script ()
             (function (makePreview s)
                       @js{
                         $(@(~j "#NAMESPACE_empty")).hide()
                         $(@(~j "#NAMESPACE_full")).show()
                       }))))

  (define (rune-editor [lang (basic-lang)])
    (enclose
     (div id: (id "main")
      (rune-injector lang
                     ;(demo-editor (codespells-basic-lang))
                     (rune-surface-component lang)
                     )
      )
     (script ([construct (call 'constructor)])
             (function (constructor)
                       @js{})
                       
             (function (onShow)
                       @js{})
             (function (compile)
                       @js{}))))

(module+ main
  (rune))