;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-4.7-2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;The worldstate is represented by the state of the door. The following strings are valid states:
;"closed", "open", "locked". A door is said to be "closed" when it is unlocked by not opened.

;Physical constants
(define CLOSED "closed")
(define OPEN "open")
(define LOCKED "locked")

;Graphical constants
(define BACKGROUND (empty-scene 150 150))

;worldstate string-> worldstate
;This function is a keypress event handler that changed the worldstate according to the keypress
;given: "u", expect:  CLOSED
;given: "o", expect: OPEN
(define (key-handler ws str)
  (cond [(equal? str "u") CLOSED]
        [(equal? str "o") OPEN]
        [else ws]))

;worldstate->worldstate
;This function checks if the door is open or unlocked, then proceeds to close it then lock it respectively.
;given: OPEN, expect: CLOSED
;given: CLOSED, expect: LOCKED
;given: LOCKED, expect: LOCKED
(define (tock ws)
  (cond [(equal? ws OPEN) CLOSED]
        [else LOCKED]))

;worldstate->Image
;This function renders the state of the door as text.
(define (render ws)
  (place-image (text ws 15 "black") 75 75 BACKGROUND))

;worldstate->worldstate
;This main function launches the world program.
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tock 3]
    [on-key key-handler]))