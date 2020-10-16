#lang at-exp racket
(provide blockly
         blockly-rune
         blockly-editor)

(require "./util.rkt" racket/runtime-path)

(define-runtime-path blockly.js
  "./blockly/blockly_compressed.js")

(define-runtime-path blocks.js
  "./blockly/blocks_compressed.js")

(define-runtime-path en.js
  "./blockly/en.js")

(define-runtime-path javascript.js
  "./blockly/javascript_compressed.js")

(require scribble/html/xml)

(define/provide-elements/not-empty xml)
(define/provide-elements/not-empty block)

(define (blockly)
  (test-modal-editor-rune-widget
   (list (blockly-rune) (blockly-editor))))

(define (blockly-rune)
    (enclose
     (div
      (div id: (id "empty")
           (svg-rune-description
            (rune-background
             #:color "red"
             (rune-image
              (above/align "left"
                           (rectangle 40 20 'solid 'black)
                           (beside (square 20 'solid 'black)
                                   (rectangle 30 20 'solid 'black))
                           (rectangle 40 20 'solid 'black))))))
      (div id: (id "full")
           style: (properties display:"none")
           (svg-rune-description
            (rune-background
             #:color "red"
             (rune-image
              (above/align "left"
                           (rectangle 40 20 'solid 'pink)
                           (beside (square 20 'solid 'pink)
                                   (rectangle 30 20 'solid 'purple))
                           (rectangle 40 20 'solid 'pink)))))))
     (script ()
             (function (makePreview s)
                       @js{
                         $(@(~j "#NAMESPACE_empty")).hide()
                         $(@(~j "#NAMESPACE_full")).show()
                       }))))

  (define (blockly-editor)
    (enclose
     (div
      (xml 'xmlns: "https://developers.google.com/blockly/xml"
           id: (id "blocklyToolbox")
           style: "display: none"
           (block type: "grouper")
           (block type: "atom"))
      (div id: (id "blocklyDiv")
           style:
           (properties width: "100%"
                       height: 720)))
     (script ([construct (call 'constructor)])
             (function (constructor)
                       @js{
 if(!window.Blockly){
  @(file->string blockly.js);
  @(file->string blocks.js);
  @(file->string en.js);
  @(file->string javascript.js);
 }

 Blockly.Blocks['grouper'] = {
  init: function() {
   this.appendStatementInput('DO');
   this.setNextStatement(true);
   this.setPreviousStatement(true);
  }
  };
   
 Blockly.Blocks['atom'] = {
  init: function() {
   this.appendDummyInput()
       .appendField(new Blockly.FieldTextInput('default text'),
          'FIELDNAME');
   this.setNextStatement(true);
   this.setPreviousStatement(true);
  }
  };

 Blockly.JavaScript['grouper'] = function(block) {
  var field = block.getFieldValue('FIELDNAME');
  var statements = Blockly.JavaScript.statementToCode(block, 'DO');

  return "(" + statements + ")\n"
};
 
 Blockly.JavaScript['atom'] = function(block) {
  var atom = block.getFieldValue('FIELDNAME');
  
  return atom + " "
};

 var blocklyDiv = document.getElementById(@(~j "NAMESPACE_blocklyDiv"));
 window.demoWorkspace = Blockly.inject(blocklyDiv, {media: 'https://blockly-demo.appspot.com/static/media/',
  toolbox: document.getElementById(@(~j "NAMESPACE_blocklyToolbox"))});
 Blockly.svgResize(demoWorkspace);                          
 })
                       
             (function (onShow)
                       @js{
 Blockly.svgResize(demoWorkspace);  })
             (function (compile)
                       @js{
                           return Blockly.JavaScript.workspaceToCode(demoWorkspace);

 }))))

(module+ main
  (blockly))