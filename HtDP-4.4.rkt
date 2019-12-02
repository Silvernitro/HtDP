;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-4.4) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;The WorldState is the height of the UFO. It is the number of pixels from the top
;of the background to the center of the UFO. It is a Number.

;Physical Constants:
(define WIDTH 70)
(define HEIGHT 150)
(define CLOSE (/ HEIGHT 3))

;Graphical Constants:
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define UFO (circle 10 "solid" "green"))

;Worldstate->Worldstate
;Decreases the height of the UFO with every tick
;Given: 100, expect: 97
(define (tock ws)
  (+ ws 3))

;Worldstate->Image
;Places UFO at the current height (of the worldstate) on the background
(define (render ws)
  (above (place-image UFO (/ WIDTH 2) (+ ws 10) BACKGROUND)
         (text (cond
                 [(>= ws 129) "Landed"]
                 [(< ws (- HEIGHT CLOSE)) "Descending"]
                 [else "Closing"])
               10 "olive")))

;Worldstate->Boolean
;Checks the current value of the worldstate to see if the program should stop.
(define (end? ws)
  (> ws 130))

;Worldstate->Worldstate
;Launches the main big-bang program
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tock]
    [stop-when end?]))