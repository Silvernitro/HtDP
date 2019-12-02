;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDO-9.0) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;A list-of-amounts is one of:
; - '()
; - (cons number list-of-amounts)

(define x (cons 10
                (cons 5
                      (cons 3
                            (cons 12
                                  (cons 15 '()))))))

;list-of-amounts -> number
;Calculates the sum of all numbers in list-of-amounts
(define (sum loa)
  (cond [(empty? loa) 0]
        [else (+ (first loa) (sum (rest loa)))]
    )
  )

;A list-of-booleans is one of:
; - '()
; - (cons boolean list-of-booleans)

(define lob (cons #true (
                         cons #true (
                                     cons #false (
                                                  cons #true '())))))

;list-of-booleans -> boolean
;Determines if at least one of the items in the list is #false.
(define (check-false lob-in)
  (cond [(empty? lob-in) #false]
        [else (if (equal? (first lob-in) #false) #true (check-false (rest lob-in)))])
  )