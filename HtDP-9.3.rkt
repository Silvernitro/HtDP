;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-9.3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;List-of-things -> Number
;Counts the no. of times s appears in LoT.
(define (count LoT s)
  (cond [(empty? LoT) 0]
        [else (if (equal? (first LoT) s)
                  (+ 1 (count (rest LoT) s))
                  (count (rest LoT) s)
                  )]
    )
  )

(define x (cons
           "a" (
               cons  "a" (
                     cons "b" (
                         cons "c" '())))))

