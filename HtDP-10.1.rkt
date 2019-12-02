;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-10.1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;A List-of-Strings, or los, is one of:
; - '()
; - (cons string List-of-Strings)

;A list-of-lines, or lol, is one of:
; - '()
; - (cons los lol)

;A list-of-numbers is one of:
; - '()
; - (cons number list-of-numbers)

;lol -> list-of-numbers
;Counts the number of words on each line in lls.
(define (line-wc lls-in)
  (cond [(empty? (first lls-in)) '()]
        [else (cons
               (wc (first lls-in)) 
               (line-wc (rest lls-in)))]
    )
  )

;los -> Number
;Counts the number of words on a single line.
(define (wc los-in)
  (cond [(empty? los-in) '()]
        [else (if (string-whitespace? (first los-in))
                  0
                  (+ 1 (wc (rest los-in))))]
    )
  )

