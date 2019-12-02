;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-5.10) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
;Editor is a structure:
;(make-editor string string)
;Editor represents a graphical one-line text editor.
;For (make-editor s1 s2), it represents (string-append s1 s2) with a cursor between s1 and s2.

;Graphical constants:
(define TEXTBOX (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "red"))

;string->Image
;Prints a textbox containing the string given by Editor.
(define (render editor-in)
  (overlay/xy (beside (text (editor-pre editor-in) 16 "black") CURSOR (text (editor-post editor-in) 16 "black")) -5 -4 TEXTBOX))

;string->string
;Takes a string as input and removes the last character.
(check-expect (remove-last "abc") "ab")
(define (remove-last string-in)
   (substring string-in 0 (- (string-length string-in) 1))
  )

;string->string
;Takes a string as input and removes the first character.
(check-expect (remove-first "abcd") "bcd")
(define (remove-first string-in)
  (substring string-in 1))

;editor->editor
;Given an editor as input, remove the last character of editor-pre and append it to the start of editor-post. Returns the new editor structue,
(check-expect (last-to-start (make-editor "abc" "def")) (make-editor "ab" "cdef"))
(define (last-to-start editor-in)
  (make-editor
   (remove-last (editor-pre editor-in))
   (string-append (string-ith (editor-pre editor-in) (- (string-length (editor-pre editor-in)) 1)) (editor-post editor-in))
  )
 )

;editor->editor
;Given an editor as input, remove the first character of editor-post and append it to the end of editor-pre. Returns the new editor structure.
(check-expect (first-to-end (make-editor "abc" "def")) (make-editor "abcd" "ef"))
(define (first-to-end editor-in)
  (make-editor
   (string-append (editor-pre editor-in) (string-ith (editor-post editor-in) 0))
   (remove-first (editor-post editor-in))
  )
 )

;editor string->string
;Given an editor structure and a string, appends the string to the end of editor-pre and returns editor-pre.
(check-expect (add-letter (make-editor "abc" "def") "o") "abco")
(define (add-letter editor-in string)
  (string-append (editor-pre editor-in) string))



;editor string -> editor
;Given an editor structure and keyevent (string), transmute the editor structure accordingly and return it.
(define (edit editor-in ke)
  (if (< (image-width (beside (text (editor-pre x) 16 "black") CURSOR (text (editor-post x) 16 "black"))) 195) 
         (cond [(equal? ke "left") (last-to-start editor-in)]
               [(equal? ke "right") (first-to-end editor-in)]
               [(equal? ke "\b") (make-editor (remove-last (editor-pre editor-in)) (editor-post editor-in))]
               [(equal? ke "\t") editor-in]
               [(equal? ke "\r") editor-in]
               [(equal? ke "shift") editor-in]
               [else (make-editor (add-letter editor-in ke) (editor-post editor-in))])
      editor-in))



;editor->editor
;Launches a big-bang program that calls other helper function according to events.
;Takes in a string to use as editor-pre.
(define (run input)
  (big-bang input
    [to-draw render]
    [on-key edit]
    ))
            
;Test constant
(define x (make-editor "" ""))