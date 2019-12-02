;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-EX47) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Happiness is a Number. It is the world state in this world.
;Define physical constants
(define MAX 100)
;Define graphical constants
(define GAUGE-WIDTH 30)
(define GAUGE (empty-scene GAUGE-WIDTH MAX))
(define H-LEVEL (rectangle GAUGE-WIDTH MAX "solid" "red"))

;Happiness->Image
;Draws the level of happiness
(define (render happiness)
  (place-image H-LEVEL (/ GAUGE-WIDTH 2) (- happiness (/ MAX 2)) GAUGE))

;Happiness->Happiness
;Decreases happiness by 0.1 per clock tick
;Given: 100, expect: 99.9
(define (tock happiness)
  (- happiness 0.1))

;Happiness->Boolean
;Returns #False when Happiness is =< 0.
;Given: 50, expect: #False
;Given: 0, expect:# True
(define (end? happiness)
  (<= happiness 0))

;Happiness String->Happiness
;Returns a new happiness state depending on the keypress.
;Given: 50 "up", expect: 50.3
;Given 50 "down", expect: 50.2
(define (keyhandler happiness keypress)
  (cond [(key=? keypress "up") (+ happiness 0.3)]
        [(key=? keypress "down") (+ happiness 0.2)]
        [else happiness]))

;Happiness->Happiness
;Launches the gauge program
(define (gauge happiness)
  (big-bang happiness
    [to-draw render]
    [on-tick tock]
    [on-key keyhandler]
    [stop-when end?]))