#lang at-exp racket
(provide three-js
         three-js-rune
         three-js-editor)

;This is purely just a showcase that a Three.js powered canvas
;  can be encapsulated by a Rune widget.
;You cannot code with it.
;Whether a "3D abstract syntax" is even a viable idea is unknown
;TODOs:
;  Handle resizing more intelligently
;  Make the constructor more efficient (reevals three.min.js every time)
;  Make an actual 3D UI for coding.  (Sounds like a Ph.D. thesis or two...)

(require "./util.rkt" racket/runtime-path)

(define-runtime-path three.js
  "./three-js/three.min.js")

(define (three-js)
  (test-modal-editor-rune-widget
   (list
    (three-js-rune) (three-js-editor))))

(define (three-js-rune)
  (enclose
   (div
    (div id: (id "empty")
         (svg-rune-description
          (rune-background
           #:color "red"
           (rune-image
            (rectangle 40 20 'solid 'black)))))
    (div id: (id "full")
         style: (properties display:"none")
         (svg-rune-description
          (rune-background
           #:color "red"
           (rune-image
            (rectangle 40 20 'solid 'pink))))))
   (script ()
           (function (makePreview s)
                     @js{
 console.log(s)
 $(@(~j "#NAMESPACE_empty")).hide()
 $(@(~j "#NAMESPACE_full")).show()
 }))))

(define (three-js-editor)
  (enclose
   (div id: (id "target"))
   (script ([construct (call 'constructor)])
           (function (constructor)
                     @js{
 @(file->string three.js)

// ------------------------------------------------
// BASIC SETUP
// ------------------------------------------------

// Create an empty scene
var scene = new THREE.Scene();

// Create a basic perspective camera
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 1000 );
camera.position.z = 2;

// Create a renderer with Antialiasing
var renderer = new THREE.WebGLRenderer({antialias:true});

// Configure renderer clear color
renderer.setClearColor("#2E2B40");

// Configure renderer size
renderer.setSize( 1200, 720 );

// Append Renderer to DOM
document.querySelector(@(~j "#NAMESPACE_target")).appendChild( renderer.domElement );

// ------------------------------------------------
// FUN STARTS HERE
// ------------------------------------------------

var geometry = new THREE.BoxGeometry( 1, 1, 1 );
var material = new THREE.MeshBasicMaterial( { color: "#433F81" } );
var cube01 = new THREE.Mesh( geometry, material );
scene.add( cube01 );

var geometry = new THREE.BoxGeometry( 3,3,3 );
var material = new THREE.MeshBasicMaterial( { color: "#433F81",wireframe:true,transparent:true } );
var cube01_wireframe = new THREE.Mesh( geometry, material );
scene.add( cube01_wireframe );

var geometry = new THREE.BoxGeometry( 1, 1, 1 );
var material = new THREE.MeshBasicMaterial( { color: "#A49FEF" } );
var cube02 = new THREE.Mesh( geometry, material );
scene.add( cube02 );

var geometry = new THREE.BoxGeometry( 3,3,3 );
var material = new THREE.MeshBasicMaterial( { color: "#A49FEF",wireframe:true,transparent:true } );
var cube02_wireframe = new THREE.Mesh( geometry, material );
scene.add( cube02_wireframe );

var geometry = new THREE.BoxGeometry( 10,0.05,0.5 );
var material = new THREE.MeshBasicMaterial( { color: "#00FFBC" } );
var bar01 = new THREE.Mesh( geometry, material );
bar01.position.z = 0.5;
scene.add( bar01 );

var geometry = new THREE.BoxGeometry( 10,0.05,0.5 );
var material = new THREE.MeshBasicMaterial( { color: "#ffffff" } );
var bar02 = new THREE.Mesh( geometry, material );
bar02.position.z = 0.5;
scene.add( bar02 );

// Render Loop
var render = function () {
  requestAnimationFrame( render );

  cube01.rotation.x += 0.01;
  cube01.rotation.y += 0.01;

  cube01_wireframe.rotation.x += 0.01;
  cube01_wireframe.rotation.y += 0.01;
  
  cube02.rotation.x -= 0.01;
  cube02.rotation.y -= 0.01;
  
  cube02_wireframe.rotation.x -= 0.01;
  cube02_wireframe.rotation.y -= 0.01;

  bar01.rotation.z-=0.01;
  bar02.rotation.z+=0.01;  
  
  // Render the scene
  renderer.render(scene, camera);
};

render();
 })
                       
           (function (onShow)
                     @js{
                         $(@(~j "#NAMESPACE_target canvas")).css({width: "100%"})
}
                     )
           (function (compile)
                     @js{}))))

(module+ main
  (three-js))