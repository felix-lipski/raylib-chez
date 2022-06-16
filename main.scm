(import (srfi :1))
(define libraylib (load-shared-object "libraylib.so"))

(define init-window (foreign-procedure "InitWindow" (int int string) void))
(define set-target-fps (foreign-procedure "SetTargetFPS" (int) void))
(define window-should-close? (foreign-procedure "WindowShouldClose" () boolean))
(define close-window (foreign-procedure "CloseWindow" () void))
(define begin-drawing (foreign-procedure "BeginDrawing" () void))
(define end-drawing (foreign-procedure "EndDrawing" () void))
(define clear-background (foreign-procedure "ClearBackground" (unsigned-32) void))
(define draw-text (foreign-procedure "DrawText" (string int int int unsigned-32) void))

(define (make-color r g b)
  (+ r
     (* 256 g)
     (* 65536 b)))

(define (make-rgba r g b a)
  (+ r
     (* g 256)
     (* b 65536))
     (* a 16777216))

(define (main-loop)
  (if (not (window-should-close?)) 
    (begin
      (begin-drawing)
      (clear-background (make-color 170 170 250))
      (draw-text "calling raylib from chez scheme" 190 200 20 (make-rgba 10 10 10 255))
      (end-drawing)
      (main-loop))
    (close-window)))

(init-window 800 450 "chez raylib")
(set-target-fps 60)
(main-loop)
