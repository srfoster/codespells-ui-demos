#lang racket

(provide (all-from-out 2htdp/image
                       webapp/js
                       codespells-runes)
         test-modal-editor-rune-widget
         rune+editor->html-rune
         html:script)

(require codespells-server
         codespells-runes
         codespells-runes/widgets/main
         (except-in webapp/js small frame header)
         (prefix-in html: (only-in website script)))

(require 2htdp/image
         (only-in codespells-runes svg-rune-description rune-background rune-image))

(define (test-modal-editor-rune-widget . rune+editors)
  (local-require codespells/demo-aether)
  
  
  (define my-lang
    (rune-lang 'codespells/demo-aether ;(build-path (current-directory) "main.rkt")
               (apply (curry rune-list #:with-paren-runes? #t)
                          (map rune+editor->html-rune rune+editors)
                          )))

  (parameterize
      ([current-editor-lang my-lang])
    (thread (thunk* (setup-demo-aether)))
    (codespells-server-start)))

(define (rune+editor->html-rune rune+editor)
  (define rune (first rune+editor))

  (define editor (second rune+editor))
  (html-rune (string->symbol (~a "editor:raw" (random 10000)))
             (modal-editor-rune-widget ;Call different f name...

              #:initial-rune
              rune

              #:editor
              editor

              #:on-show-editor
              (lambda (inner-c)
                (call-method inner-c 'onShow)
                )

              #:compile-editor ;Needs to return a string??  Clearer fname?
              (lambda (inner-c)
                (call-method inner-c 'compile))

                          
              #:update-rune-preview
              (lambda (rune-c compiled-v)
                (call-method rune-c 'makePreview compiled-v))
              )))