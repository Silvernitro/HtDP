;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-10.3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;lol -> string
;Concatenates all words in a file into a single string.
(define (collapse lol-in)
  (cond [(empty? lol-in) ""]
        [else (string-append (line-to-string (first lol-in)) "\n"
                 (collapse (rest lol-in)))
              ]
    )
  )

;los -> string
;concatenates the words on a single line into a single string.
(define (line-to-string los-in)
  (cond [(empty? los-in) ""]
        [else (string-append (first los-in) " " (line-to-string (rest los-in)))]
    )
  )


;file->file
;Reads a file, removes all articles, and returns a new file.
;An article is one of:
; "a","an", "the"
(define (remove-article file)
  (write-file (line-process
   (read-words/line file))
  ))

;lol -> string
;Concatenates all words in a file into a single string.
(define (line-process lol-in)
  (cond [(empty? lol-in) ""]
        [else (string-append (remove-line-article (first lol-in)) "\n"
                 (line-process (rest lol-in)))
              ]
    )
  )

(define (remove-line-article los-in)
  (cond [(empty? los-in) ""]
        [(equal? (first los-in) "a") ""]
        [(equal? (first los-in) "an") ""]
        [(equal? (first los-in) "the") ""]
        [else (string-append (first los-in) " " (line-to-string (rest los-in)))]
    )
  )