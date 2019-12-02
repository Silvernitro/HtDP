;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname HtDP-11.3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;A list-of-numbers, or lon is one of:
; - '()
; - (cons Number lon)

;list-of-numbers -> list-of-numbers
;Sorts a lon in descending order and returns another lon
(define (sort lon-in)
  (cond [(empty? lon-in) '()]
        [else (insert (first lon-in) (sort (rest lon-in)))]
    )
  )

;Number lon(sorted) -> lon (sorted)
(define (insert number lon)
  (cond [(empty? lon) (list number)]
        [else (if (>= number (first lon))
                  (cons number lon)
                  (cons (first lon) (insert number (rest lon))))]
        )
  )