;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname HtDP-25.2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;[list-of numbers] -> [list-of numbers]
;Sorts a list-of numbers using quicksort and returns the sorted list.
(define (implement-quicksort seq)
  (cond [(empty? seq) '()]
        [(equal? (length seq) 1) seq]
        [(equal? (length (smallers (rest seq) (first seq))) (length seq)) (error "seq consists of same numbers")]
        [else (local ((define pivot (first seq)))
                (append 
                (implement-quicksort (smallers (rest seq) pivot))
                (list pivot)
                (implement-quicksort (largers (rest seq) pivot))
                )
                )]
    )
  )

;[list-of numbers] number -> [list-of numbers]
;Takes in lon and n, and returns a new lon where every element is smaller than n.
(define (smallers alon n)
  (cond [(empty? alon) '()]
        [else (if (<= (first alon) n)
                  (cons (first alon) (smallers (rest alon) n))
                  (smallers (rest alon) n)
                  )]
        )
  )

(define (largers alon n)
  (cond [(empty? alon) '()]
        [else (if (> (first alon) n)
                  (cons (first alon) (largers (rest alon) n))
                  (largers (rest alon) n)
                  )]
        )
  )

(define alon-eg (list 2 4 4 6 3 7))