(load "../helpers.scm")

;; This produces the list in reverse order
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (sqr (car things))
                    answer))))

  (trace iter)

  (iter items '()))
;; We can see from the trace that the cons operation
;; places the next value in 'things' always at the
;; beginning of the 'answer' list.

;; This is in contrast to the non-iterative approach which
;; builds the list like:
;; (cons 1 (cons 4 (cons 9 .... (cons '())))) which therefore
;; 1 will be the last element to be added due to the recursive
;; nature of the operation.

;; | > (iter '(1 2 3 4 5 6 7 8 9 10) '())
;; | > (iter '(2 3 4 5 6 7 8 9 10) '(1))
;; | > (iter '(3 4 5 6 7 8 9 10) '(4 1))
;; | > (iter '(4 5 6 7 8 9 10) '(9 4 1))
;; | > (iter '(5 6 7 8 9 10) '(16 9 4 1))
;; | > (iter '(6 7 8 9 10) '(25 16 9 4 1))
;; | > (iter '(7 8 9 10) '(36 25 16 9 4 1))
;; | > (iter '(8 9 10) '(49 36 25 16 9 4 1))
;; | > (iter '(9 10) '(64 49 36 25 16 9 4 1))
;; | > (iter '(10) '(81 64 49 36 25 16 9 4 1))
;; | > (iter '() '(100 81 64 49 36 25 16 9 4 1))
;; | (100 81 64 49 36 25 16 9 4 1)

(define (square-list-alt items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (sqr (car things))))))
  (trace iter)

  (iter items '()))

;; (square-list-alt (list 1 2 3 4 5 6 7 8 9 10))
;; ((((((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49) . 64) . 81) . 100)

;; The problem here is that the initial pair is created with an empty list
;; as the car, and an integer as the cdr. This parttern continues until you have
;; built one pair, where the car of the pair is an nested pair.
;; | > (iter '(1 2 3 4 5 6 7 8 9 10) '())
;; | > (iter '(2 3 4 5 6 7 8 9 10) '(() . 1))
;; | > (iter '(3 4 5 6 7 8 9 10) '((() . 1) . 4))
;; | > (iter '(4 5 6 7 8 9 10) '(((() . 1) . 4) . 9))
;; | > (iter '(5 6 7 8 9 10) '((((() . 1) . 4) . 9) . 16))
;; | > (iter '(6 7 8 9 10) '(((((() . 1) . 4) . 9) . 16) . 25))
;; | > (iter '(7 8 9 10) '((((((() . 1) . 4) . 9) . 16) . 25) . 36))
;; | > (iter '(8 9 10) '(((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49))
;; | > (iter '(9 10) '((((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49) . 64))
;; | > (iter '(10) '(((((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49) . 64) . 81))
;; | > (iter '() '((((((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49) . 64) . 81...
;; | ((((((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49) . 64) . 81) . 100)
;; ((((((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49) . 64) . 81) . 100)

;; An alternative view point is to consider that the cdr of the result is an integer
;; not a list. And the car of the result is a pair. 

;; (car answer)
;; (((((((((() . 1) . 4) . 9) . 16) . 25) . 36) . 49) . 64) . 81)

;; (cdr answer)
;; 100
