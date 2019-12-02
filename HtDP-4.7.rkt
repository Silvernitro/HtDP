;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-4.7) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;The worldstate of TrafficLight is represented by the following strings:
;"red", "amber", "green"

;Physical constants
(define WIDTH 500)
(define HEIGHT 100)
(define RED "red")
(define AMBER "amber")
(define GREEN "green")

;Graphical constants
(define BACKGROUND
  (empty-scene WIDTH HEIGHT))

;TrafficLight->TrafficLight
;This function changes the state of TrafficLight (color) depending every tick.
;Given: "red", expect: "green"
;Given: "green", expect: "amber"
;Given: "amber", expect: "red"
(define (tl-next ws)
  (cond [(equal? ws RED) GREEN]
        [(equal? ws AMBER) RED]
        [(equal? ws GREEN) AMBER]))

;TrafficLight->Image
;Draws the correct trafficlight diagram depending on the current state.
(define (render ws)
  (place-image (text ws 15 "black") (/ WIDTH 2) (/ HEIGHT 2) BACKGROUND))

;TrafficLight->TrafficLight
;Launches the main program that tracks the world states.
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tl-next 1]))