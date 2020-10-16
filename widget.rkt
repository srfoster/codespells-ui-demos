#lang at-exp racket
(provide widget
         widget-rune
         widget-editor)

(require "./util.rkt")


(define (widget)
  (test-modal-editor-rune-widget
   (list
    (widget-rune) (widget-editor))))

(define (widget-rune)
  (enclose
   (div
    (div id: (id "empty")
         (svg-rune-description
          (rune-background
           #:color "red"
           (rune-image
            (bitmap/url "https://static.thenounproject.com/png/805826-200.png")))))
    (div id: (id "full")
         style: (properties display:"none")
         (svg-rune-description
          (rune-background
           #:color "red"
           (rune-image
            (bitmap/url "https://static.thenounproject.com/png/805826-200.png"))))))
   (script ()
           (function (makePreview s)
                     @js{
 console.log(s)
 $(@(~j "#NAMESPACE_empty")).hide()
 $(@(~j "#NAMESPACE_full")).show()
 }))))

(define (widget-editor)
  (enclose
   (row
    (col-6
     (div
      (h4 "How to Spawn with a Mod")
      (p "A " (tt "(spawn ...)") " expression is used to spawn a modded 3d object in-game.")
      (p "Watch the video below to learn more about how " (tt "(spawn ...)") " expressions work.
          Or use the widget on the right to create one now."))
     (iframe width: "560"
             height: "315"
             src: "https://www.youtube.com/embed/dRsWwRMQqDo"
             frameborder: "0"
             'allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 'allowfullscreen: #t))
    (col-6
     (div    style: (properties font-size: "24pt")
      "I want to spawn a:"
      (div class: "custom-control custom-radio"
           style: (properties font-size: "12pt")
           (input id: (id "r1") 'data-val: "fire" name: "customRadio" type: "radio" class: "custom-control-input" on-click: (call 'toggle 'this))
           (label 'for: (id "r1") class: "custom-control-label" "Fire"))
    
      (div class: "custom-control custom-radio"
           style: (properties font-size: "12pt")
           (input id: (id "r2") 'data-val: "box" name: "customRadio" type: "radio" class: "custom-control-input" on-click: (call 'toggle 'this))
           (label 'for: (id "r2") class: "custom-control-label" "Box"))
      
      (code
       (pre "   (spawn " (span id: (id 'thing) "fire") ")"))
      (br) (br)
      (hr)
      )))
   
   (script ([construct (call 'constructor)]
            [val "fire"])
           (function (toggle input)
                     @js{@(ns 'val) = $(input).attr("data-val");
                         $(@(~j "#NAMESPACE_thing")).html(@(ns 'val))})
           
           (function (constructor)
                     @js{})
                       
           (function (onShow)
                     @js{})
           (function (compile)
                     @js{return "(spawn " + @(ns 'val) + ")"}))))

(module+ main
  (widget))