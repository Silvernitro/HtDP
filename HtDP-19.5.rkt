;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname HtDP-19.5) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;A Binary Tree (BT) is one of:
; - NONE
; - (make-node ssn name Node Node)

;A node is a struct:
(define-struct node [ssn name left right])

(define-struct no-info [])
(define NONE (make-no-info))

(define bt_eg (make-node
  15
  'd
  NONE
  (make-node
    24 'i NONE NONE)))

(define bst-eg (make-node 63 'x
                          (make-node 29 'x
                                     (make-node 15 'x
                                                (make-node 10 'x NONE NONE)
                                                (make-node 24 'x NONE NONE)
                                                )                                  
                                     NONE)
                          (make-node 89 'x
                                     (make-node 77 'x NONE NONE)
                                     (make-node 95 'x NONE
                                                (make-node 99 'x NONE NONE)
                                                )
                                     )
                          )
  )

;BT number -> Boolean
;Determine if a given number occurs in a given BT.
(define (contains-BT? bt n)
  (cond [(no-info? bt) #false]
        [else (or (equal? (node-ssn bt) n)
                  (contains-BT? (node-left bt) n)
                  (contains-BT? (node-right bt) n)
                  )]
    )
  )

(define (search-BT? bt n)
  (cond [(no-info? bt) #false]
        [else (if (equal? (node-ssn bt) n) (node-name bt)
                  (if (contains-BT? (node-left bt) n)
                      (search-BT? (node-left bt) n)
                      (search-BT? (node-right bt) n ))
                  )
              ]
    )
  )

(define (in-order bt)
  (cond [(no-info? bt) '()]
        [else (if (and (no-info? (node-left bt)) (no-info? (node-right bt)))
                      (list (node-ssn bt))
                  (append (in-order (node-left bt)) (list (node-ssn bt)) (in-order (node-right bt)))
                  )]
    )
  )

;BST number -> Boolean
;Searches a Binary Search Tree (bst) for a node where node-ssn = number.
;Returns the name of that node or NONE if no nodes match the condition.
(define (search-BST bst n)
  (cond [(no-info? bst) NONE]
        [else (if (equal? (node-ssn bst) n)
                  (node-name bst)
                  (if (< (node-ssn bst) n)
                      (search-BST (node-right bst) n)
                      (search-BST (node-left bst) n)
                      )
               )
              ]
    )
  )

;bst number symbol -> bst
;Take in a bst, number, and symbol and creates a new bst with a new node created with number and symbol.
(define (make-BST bst n s)
  (cond [(no-info? bst) (make-node n s NONE NONE)]
        [else (if (< (node-ssn bst) n)
                  (make-node (node-ssn bst) (node-name bst) (node-left bst) (make-BST (node-right bst) n s))
                  (make-node (node-ssn bst) (node-name bst) (make-BST (node-left bst) n s) (node-right bst))
               )
         ]
    )
  )

;[List-of [list number symbol]] -> BST
;Creates a BST from a list of numbers and strings.
(define (create-bst-from-list list-in)
  (cond [(empty? list-in) NONE]
        [else (make-BST (create-bst-from-list (rest list-in))
                        (first (first list-in))
                        (rest (first list-in))
                        )]
        )
  )