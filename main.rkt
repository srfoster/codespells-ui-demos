#lang racket

;Various demos of the power of one simple concept:
;  A Rune that "encapsulates" a custom editor, which (itself) need not be Rune-based.
;Wanna compose Blockly, with Runes, with text, with Nodes?  You can!
;  Your editor just needs to compile to S-expressions.

(require "hello-world.rkt")
;(hello-world)

(require "blockly.rkt")
;(blockly)

(require "litegraph.rkt")
;(litegraph)

(require "3d.rkt")
;(three-js)

(require "rune.rkt")
(rune)

#;
(module+ main
  (require "./util.rkt")
  
  (test-modal-editor-rune-widget
   (list (litegraph-rune) (litegraph-editor))
   (list (blockly-rune) (blockly-editor))
   
   ))
